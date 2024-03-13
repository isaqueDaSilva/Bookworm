//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import SwiftUI

struct BookDetailView: View {
    // MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: BookDetailViewModel
    
    // MARK: View
    var body: some View {
        // START: LIST
        List {
            // START: SECTION 1
            Section {
                VStack {
                    Cover(
                        coverImage: viewModel.coverImage,
                        title: viewModel.title
                    )
                    
                    Description(
                        title: viewModel.title,
                        author: viewModel.author
                    )
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.listLightGray)
            // END: SECTION 1
            
            // START: SECTION 2
            Section("More Information") {
                LabeledContent("Release Date:") {
                    Text(viewModel.releaseDate)
                }
                
                LabeledContent("Genre:") {
                    Text(viewModel.genre)
                }
            }
            // END: SECTION 2
            
            // START: SECTION 3
            Section("Reading Information") {
                LabeledContent("Stating of Reading:") {
                    Text(viewModel.startOfReading)
                }
                if viewModel.isFinished {
                    LabeledContent("End of Reading:") {
                        Text(viewModel.endOfReading)
                    }
                }
            }
            // END: SECTION 3
            
            if viewModel.isFinished {
                // START: SECTION 4
                Section("Review") {
                    LabeledContent("Rating:") {
                        RatingStars(rating: .constant(viewModel.rating))
                    }
                    
                    LabeledContent("Review:") {
                        Text(viewModel.review)
                    }
                }
                // END: SECTION 4
            }
            
            // START: SECTION 5
            Section {
                Button {
                    viewModel.showingAnnotationView = true
                } label: {
                    HStack {
                        LabeledContent("Annotations") {
                            Text(viewModel.annotationsCount, format: .number)
                            Icons.chevronRight.systemImage
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            // END: SECTION 5
            
            // START: SECTION 6
            Section {
                Button(role: .destructive) {
                    // Displays an Alert to confirm
                    // whether the user wants to delete this book.
                    
                    viewModel.displayDeleteAlert()
                } label: {
                    Label("Delete Book", systemImage: Icons.trash.rawValue)
                        .foregroundStyle(.red)
                }
            }
            // END: SECTION 6
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // MARK: - Check this logic later
            viewModel.fetchChanges()
        }
        .toolbar {
            Button("Edit") {
                // Displays the BookFormView.
                viewModel.showingEditView = true
            }
        }
        .sheet(isPresented: $viewModel.showingEditView) {
            BookFormView(storage: viewModel.storage, book: viewModel.book)
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            if viewModel.isDeletingAlert {
                Button("Cancel", role: .cancel) { }
                
                Button("OK", role: .destructive) {
                    // Performs the book deletion and dismiss this View.
                    
                    viewModel.deleteBook()
                    dismiss()
                }
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .navigationDestination(isPresented: $viewModel.showingAnnotationView) {
            AnnotationListView(storage: viewModel.storage, book: viewModel.book)
        }
        // END: LIST
    }
    
    /// This view displays the all book selected information.
    /// - Parameters:
    ///   - storage: The type that contains the default container and viewContext types, of Core Data.
    ///   - book: The book that will have its information displayed.
    init(storage: Storage, book: Book) {
        _viewModel = StateObject(wrappedValue: BookDetailViewModel(storage: storage, book: book))
    }
}

#Preview {
    NavigationStack {
        BookDetailView(storage: .preview, book: dummyBook)
    }
}
