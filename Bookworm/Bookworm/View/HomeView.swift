//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    let colums = [GridItem(.adaptive(minimum: 150), spacing: 20, alignment: .center)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: colums, spacing: 20) {
                    ForEach(viewModel.books) { book in
                        NavigationLink(value: book) {
                            Cover(
                                title: book.wrappedTitle,
                                author: book.wrappedAuthorName
                            )
                            .contextMenu {
                                Button("Delete Book", systemImage: Icons.trash.rawValue, role: .destructive) {
                                    viewModel.deleteBook(book)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .disabled(book.isDisabled)
                    }
                }
                .navigationTitle("Bookworm")
                .padding(.horizontal)
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
                .sheet(isPresented: $viewModel.showingAddNewBook) {
                    BookFormView(storage: viewModel.storage) {
                        viewModel.fetchBooks()
                    }
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
