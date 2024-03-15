//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - View Properties
    @StateObject private var viewModel: HomeViewModel
    let colums = [GridItem(.adaptive(minimum: 150), spacing: 10, alignment: .top)]
    
    // MARK: - View
    var body: some View {
        // START: NAV
        NavigationStack {
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
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .foregroundStyle(Color.overlayColor(book))
                                }
                                
                                Description(
                                    title: book.wrappedTitle,
                                    author: book.wrappedAuthorName
                                )
                            }
                            .shadow(radius: 5)
                            .padding(8)
                            .contextMenu {
                                Button(
                                    "Delete Book",
                                    systemImage: Icons.trash.rawValue,
                                    role: .destructive
                                ) {
                                    // When this button is pressed,
                                    // the book will be permanently deleted
                                    // and will disappear from the screen.
                                    
                                    viewModel.deleteBook(book)
                                }
                            }
                        }
                        .buttonStyle(.plain)
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
                .sheet(
                    isPresented: $viewModel.showingAddNewBook,
                    onDismiss: viewModel.fetchBooks
                ) {
                    BookFormView(storage: viewModel.storage)
                }
                .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
                } message: {
                    Text(viewModel.alertMessage)
                }
                // END: LazyVGrid
            }
            // END: SCROLL
        } 
        // END: NAV
    }
    
    /// This View shows the entire collection of books that the user has.
    /// - Parameter storage: The type that contains the default container and viewContext types, of Core Data.
    init(storage: Storage) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(storage: storage))
    }
}

#Preview {
    HomeView(storage: Storage.preview)
}
