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
                if viewModel.filter == .genre {
                    Picker("Select", selection: $viewModel.text) {
                        ForEach(viewModel.genres, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                if viewModel.filter == .ratingEqual {
                    Picker("Select", selection: $viewModel.text) {
                        ForEach(viewModel.rating, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                List {
                    ForEach(viewModel.search) { book in
                        NavigationLink {
                            BookDetailsView(book: book)
                        } label: {
                            HStack {
                                EmojiRating(rating: book.rating)
                                VStack(alignment: .leading) {
                                    Text(book.wrappedTitle)
                                        .font(.title3.bold())
                                        .foregroundColor(viewModel.textColor(book.rating))
                                    Text(book.author?.wrappedName ?? "Unknown Author")
                                        .font(.headline.bold())
                                        .foregroundColor(.black.opacity(0.4))
                                }
                            }
                        }
                        
                    }
                    .onDelete(perform: viewModel.deleteBook)
                }
                .listStyle(.plain)
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
            .sheet(isPresented: $viewModel.showingAddNewBook) {
                AddNewBookView()
            }
        }
    }
}
