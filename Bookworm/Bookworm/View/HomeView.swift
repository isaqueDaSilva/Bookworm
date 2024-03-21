//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - View Properties
    @Namespace private var transition
    @StateObject private var viewModel: HomeViewModel
    let colums = [GridItem(.adaptive(minimum: 150), spacing: 10, alignment: .top)]
    
    // MARK: - View
    var body: some View {
        // START: NAV
        NavigationStack {
            Group {
                if viewModel.books.isEmpty {
                    ContentUnavailableView(
                        "No Books Saved",
                        systemImage: Icons.bookVertical.rawValue,
                        description: 
                            Text("Tap the + Button to create one.").bold()
                    )
                    .transition(AnyTransition.opacity)
                    .matchedGeometryEffect(id: "transition", in: transition)
                } else {
                    BookListView()
                        .matchedGeometryEffect(id: "transition", in: transition)
                }
            }
            .navigationTitle("Bookworm")
            .onAppear {
                // Fetch Books saved in Core Data:
                // When this View appears, the search for saved books
                // will be carried out, and after that these results
                // will be displayed on the screen for the user.
                viewModel.fetchBooks()
            }
            .toolbar {
                Button {
                    // Make the 'showingAddNewBook' as true
                    // and displat the BookFormView.
                    
                    viewModel.showingAddNewBook = true
                } label: {
                    Icons.plus.systemImage
                }
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(storage: viewModel.storage, book: book)
            }
            .sheet(isPresented: $viewModel.showingAddNewBook) {
                BookFormView(storage: viewModel.storage) {
                    withAnimation(.spring.delay(0.1)) {
                        viewModel.fetchBooks()
                    }
                }
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            } message: {
                Text(viewModel.alertMessage)
            }
            
        }
        // END: NAV
    }
    
    /// This View shows the entire collection of books that the user has.
    /// - Parameter storage: The type that contains the default container and viewContext types, of Core Data.
    init(storage: Storage) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(storage: storage))
    }
}

// MARK: - View Populated State

extension HomeView {
    @ViewBuilder
    private func BookListView() -> some View {
        // START: SCROLL
        ScrollView {
            // START: LazyVGrid
            LazyVGrid(columns: colums, spacing: 20) {
                ForEach(viewModel.books) { book in
                    NavigationLink(value: book) {
                        VStack(alignment: .leading) {
                            Cover(
                                coverImage: book.coverImage,
                                title: book.wrappedTitle
                            )
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
                            .contextMenu {
                                Button(
                                    "Delete Book",
                                    systemImage: Icons.trash.rawValue,
                                    role: .destructive
                                ) {
                                    // When this button is pressed,
                                    // the book will be permanently deleted
                                    // and will disappear from the screen
                                    // with the spring animmation.
                                    
                                    withAnimation(.spring.delay(0.65)) {
                                        viewModel.deleteBook(book)
                                    }
                                }
                            }
                            
                            Description(
                                title: book.wrappedTitle,
                                author: book.wrappedAuthorName
                            )
                            .disabled(true)
                        }
                    }
                    .navigationStackButtonStyle()
                }
            }
            // END: LazyVGrid
        }
        // END: SCROLL
    }
}

#Preview {
    HomeView(storage: Storage.preview)
}
