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
            VStack {
                if viewModel.filter != .all {
                    Picker("Select", selection: $viewModel.text) {
                        if viewModel.filter == .author {
                            ForEach(viewModel.books) { author in
                                Text(author.author?.wrappedName ?? "Unknown Author")
                            }
                        }
                        
                        if viewModel.filter == .genre {
                            ForEach(viewModel.genres, id: \.self) {
                                Text($0)
                            }
                        }
                        
                        if viewModel.filter == .ratingEqual || viewModel.filter == .ratingGreaterThan || viewModel.filter == .ratingLessThan {
                            ForEach(viewModel.rating, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                List {
                    ForEach(viewModel.search) { book in
                        NavigationLink {
                            Text(book.wrappedTitle)
                        } label: {
                            VStack {
                                Text(book.wrappedTitle)
                                Text(book.author?.wrappedName ?? "Unknown Author")
                            }
                        }
                        
                    }
                    .onDelete(perform: viewModel.deleteBook)
                }
            }
            .padding()
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
