//
//  BookEdit.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI
import PhotosUI

struct BookEdit: View {
    @Binding var coverImage: UIImage?
    @Binding var pickerItemSelect: PhotosPickerItem?
    @Binding var title: String
    @Binding var selectedAuthor: Author?
    @Binding var releaseDate: Date
    @Binding var selectedGenre: Genre?
    @Binding var startOfReading: Date
    @Binding var endOfReading: Date
    @Binding var isFinished: Bool
    @Binding var rating: Int
    @Binding var review: String
    
    var body: some View {
        Form {
            cover
            
            moreInformations
            
            readingInformations
        }
    }
}

extension BookEdit {
    @ViewBuilder
    private var cover: some View {
        Section {
            VStack {
                Cover(
                    coverImage: coverImage,
                    title: title.isEmpty ? "No Title" : title,
                    size: .coverFullSize
                )
                
                PhotosPicker("Select an Cover", selection: $pickerItemSelect)
                    .buttonStyle(.borderedProminent)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .listRowBackground(Color.clear)
        .listRowInsets(.init())
    }
}
 
extension BookEdit {
    @ViewBuilder
    private var moreInformations: some View {
        
        Section("More Information") {
            LabeledContent("Title:") {
                TextField("Insert the title here...", text: $title)
                    .multilineTextAlignment(.trailing)
            }
            
            NavigationLink {
                AuthorsView(author: $selectedAuthor)
            } label: {
                LabeledContent("Author") {
                    Text(selectedAuthor?.wrappedName ?? "Select an Author")
                }
            }
            .buttonStyle(.plain)
            
            NavigationLink {
                GenresView(selectedGenre: $selectedGenre)
            } label: {
                LabeledContent("Genre") {
                    Text(selectedGenre?.wrappedName ?? "Select a Genre")
                }
            }
            
            DatePicker(
                "Release Date:",
                selection: $releaseDate,
                in: ...Date.now,
                displayedComponents: .date
            )
        }
    }
}

extension BookEdit {
    @ViewBuilder
    private var readingInformations: some View {
        Section("Reading Information") {
            DatePicker(
                "Starting of Reading:",
                selection: $startOfReading,
                in: ...Date.now,
                displayedComponents: .date
            )
            
            if isFinished {
                DatePicker(
                    "End of Reading:",
                    selection: $endOfReading,
                    in: ...Date.now,
                    displayedComponents: .date
                )
            }
            
            Toggle(
                "Have you finished reading yet?",
                isOn: $isFinished.animation(.spring())
            )
            
            if isFinished {
                Section("Review") {
                    LabeledContent("Rating:") {
                        RatingStars(rating: $rating)
                    }
                    
                    TextField(
                        "Insert the revire here...",
                        text: $review,
                        axis: .vertical
                    )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookEdit(
            coverImage: .constant(.checkmark),
            pickerItemSelect: .constant(nil),
            title: .constant("Harry Potter"),
            selectedAuthor: .constant(nil),
            releaseDate: .constant(.now),
            selectedGenre: .constant(nil),
            startOfReading: .constant(.now),
            endOfReading: .constant(.now),
            isFinished: .constant(false),
            rating: .constant(1),
            review: .constant("")
        )
    }
}
