//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    let colums = [GridItem(.adaptive(minimum: 150), spacing: 10, alignment: .top)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                                        .foregroundStyle(viewModel.overlayColor(book))
                                }
                                
                                Description(
                                    title: book.wrappedTitle,
                                    author: book.wrappedAuthorName
                                )
                            }
                            .shadow(radius: 5)
                            .padding(8)
                            .contextMenu {
                                Button("Delete Book", systemImage: Icons.trash.rawValue, role: .destructive) {
                                    viewModel.deleteBook(book)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .navigationTitle("Bookworm")
                .onAppear {
                    viewModel.fetchBooks()
                }
                .toolbar {
                    Button {
                        viewModel.showingAddNewBook = true
                    } label: {
                        Icons.plus.systemImage
                    }
                }
                .navigationDestination(for: Book.self) { book in
                    BookDetailView(storage: viewModel.storage, book: book)
                }
                .sheet(isPresented: $viewModel.showingAddNewBook, onDismiss: viewModel.fetchBooks) {
                    BookFormView(storage: viewModel.storage)
                }
                .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
                } message: {
                    Text(viewModel.alertMessage)
                }
            }
        }
    }
    
    init(storage: Storage) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(storage: storage))
    }
}

#Preview {
    HomeView(storage: Storage.preview)
}
