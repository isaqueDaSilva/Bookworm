//
//  CreateNewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 28/02/24.
//

import SwiftUI
import PhotosUI

struct BookFormView: View {
    // MARK: - View Properties
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: BookFormViewModel
    
    // MARK: - View
    var body: some View {
        // START: NAV
        NavigationStack {
            // START: FORM
            Form {
                // START: SECTION 1
                Section {
                    VStack {
                        Cover(
                            coverImage: viewModel.coverImage,
                            title: viewModel.title.isEmpty ? "No Title" : viewModel.title
                        )
                        PhotosPicker("Select an Cover", selection: $viewModel.pickerItemSelect)
                            .buttonStyle(.borderedProminent)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color.listLightGray)
                // END: SECTION 1
                
                // START: SECTION 2
                Section("More Information") {
                    LabeledContent("Title:") {
                        TextField("Insert the title here...", text: $viewModel.title)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    Button {
                        // Moves to the Author View.
                        
                        viewModel.showingAuthorSelectionView = true
                    } label: {
                        LabeledContent("Author") {
                            HStack {
                                Text(viewModel.author?.wrappedName ?? "Select an Author")
                                
                                Icons.chevronRight.systemImage
                            }
                        }
                    }
                    .buttonStyle(.plain)

                    
                    DatePicker(
                        "Release Date:",
                        selection: $viewModel.releaseDate,
                        in: ...Date.now,
                        displayedComponents: .date
                    )
                    
                    Picker("Genre:", selection: $viewModel.genre) {
                        ForEach(Genre.allCases, id: \.id) {
                            Text($0.rawValue)
                        }
                    }
                } 
                // END: SECTION: 2
                
                // START: SECTION 3
                Section("Reading Information") {
                    DatePicker(
                        "Starting of Reading:",
                        selection: $viewModel.startOfReading,
                        in: ...Date.now,
                        displayedComponents: .date
                    )
                    
                    if viewModel.isFinished {
                        DatePicker(
                            "End of Reading:",
                            selection: $viewModel.endOfReading,
                            in: ...Date.now,
                            displayedComponents: .date
                        )
                    }
                    
                    Toggle("Have you finished reading yet?", isOn: $viewModel.isFinished.animation(.spring()))
                    
                }
                // END: SECTION 3
                
                if viewModel.isFinished {
                    // START: SECTION 4
                    Section("Review") {
                        LabeledContent("Rating:") {
                            RatingStars(rating: $viewModel.rating)
                        }
                        
                        TextField("Insert the revire here...", text: $viewModel.review, axis: .vertical)
                    }
                    // END: SECTION 4
                }
            }
            .navigationTitle(viewModel.navTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: viewModel.author) { oldAuthor, newAuthor in
                // If the authors property has some change
                // the UI will be updated.
                
                if viewModel.author != oldAuthor {
                    viewModel.author = newAuthor
                }
            }
            .navigationDestination(isPresented: $viewModel.showingAuthorSelectionView) {
                AuthorSelectionView(
                    authorSelected: $viewModel.author,
                    storage: viewModel.storage
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        // Dismiss the View
                        
                        dismiss()
                    } label: {
                        HStack {
                            Icons.chevronLeft.systemImage
                            Text("Back")
                        }
                    }
                }
                
                ToolbarItem {
                    Button {
                        // Saves the changes
                        // and dismiss the view
                        
                        viewModel.save()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(viewModel.isDisabled)
                }
            }
            .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
            } message: {
                Text(viewModel.errorMessage)
            }
            // END: FORM
        }
        // END: NAV
    }
    
    /// The view shows the form for user will be create a new book.
    /// - Parameter storage: The type that contains the default container and viewContext types, of Core Data.
    init(storage: Storage) {
        _viewModel = StateObject(wrappedValue: BookFormViewModel(storage: storage))
    }
    
    /// The view shows the form for user will be update an existing book.
    /// - Parameters:
    ///   - storage: The type that contains the default container and viewContext types, of Core Data.
    ///   - book: An existing book that will be updated
    init(storage: Storage, book: Book) {
        _viewModel = StateObject(wrappedValue: BookFormViewModel(storage: storage, book: book))
    }
}

#Preview {
    BookFormView(storage: .preview)
}
