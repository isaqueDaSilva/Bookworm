//
//  AddNewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct AddNewBookView: View {
    @State private var title = ""
    @State private var releaseDate = Date()
    @State private var genre: Genre = .fantasy
    @State private var review = ""
    @State private var rating = 1
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                Form {
                    Section {
                        BookCover(width: 135, height: 180, customText: "T")
                        .listRowBackground(Color(CGColor(red: 240, green: 240, blue: 246, alpha: 0)))
                    }
                    .frame(width: geo.size.width)
                    
                    Section("Book's information") {
                        TextField("Insert the Book's title...", text: $title)
                        DatePicker("Release date:", selection: $releaseDate, in: ...Date.now, displayedComponents: .date)
                        Picker("Book's genre:", selection: $genre) {
                            ForEach(Genre.allCases, id: \.rawValue) {
                                Text($0.rawValue)
                            }
                        }
                        
                        HStack {
                            Text("Rating:")
                            Spacer()
                            RatingStars(rating: $rating)
                        }
                    }
                    
                    Section("Review") {
                        TextField("Write a review for this book...", text: $review)
                    }
                }
                .navigationTitle("Add new Book")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton { }
                    }
                    
                    ToolbarItem {
                        SaveButton { }
                    }
                }
            }
        }
    }
}

#Preview {
    AddNewBookView()
}
