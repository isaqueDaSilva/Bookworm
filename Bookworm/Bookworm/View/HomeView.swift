//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct BooksView: View {
    @EnvironmentObject var storage: Storage
    @StateObject private var viewModel = BooksViewModel()
    
    let colums = [GridItem(.adaptive(minimum: 150), spacing: 20, alignment: .center)]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: colums, spacing: 20) {
                    ForEach(storage.books) { book in
                        NavigationLink(value: book) {
                            Cover(
                                title: book.title,
                                author: book.author.authorName
                            )
                            .contextMenu {
                                Button("Delete Book", systemImage: Icons.trash.rawValue, role: .destructive) {
                                    viewModel.deleteBook(book) { bookForDelete in
                                        try storage.deleteBook(bookForDelete)
                                    }
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .disabled(book.isDisabled)
                    }
                }
                .navigationTitle("Bookworm")
                .toolbar {
                    Button {
                        viewModel.showingAddNewBook = true
                    } label: {
                        Icons.plus.systemImage
                    }
                }
                .navigationDestination(for: Book.self) { book in
                    Text(book.title)
                }
                .sheet(isPresented: $viewModel.showingAddNewBook) {
                    
                }
            }
        }
    }
}

#Preview {
    BooksView()
        .environmentObject(Storage.preview)
}
