//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct BooksView: View {
    @StateObject var viewModel = BooksViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    NavigationLink {
                        Text(book.wrappedTitle)
                    } label: {
                        VStack {
                            Text(book.wrappedTitle)
                            Text(book.wrappedAuthor)
                        }
                    }

                }
                .onDelete(perform: viewModel.deleteBook)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem {
                    HStack {
                        Menu {
                            Picker("Filter", selection: $viewModel.filter) {
                                ForEach(Filter.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                        
                        Button {
                            viewModel.showingAddNewBook = true
                        } label: {
                            Label("Add new Book", systemImage: "plus")
                        }
                    }
                }
            }
        }
    }
}
