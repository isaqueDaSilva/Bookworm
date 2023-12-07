//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct BooksView: View {
    @StateObject var viewModel: BooksViewModel
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.showingPicker {
                    Picker("Select", selection: $viewModel.text) {
                        ForEach(viewModel.choiceText, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    ForEach(viewModel.search) { book in
                        NavigationLink {
                            BookDetailsView(manager: viewModel.manager, book: book)
                        } label: {
                            HStack {
                                EmojiRating(rating: book.rating)
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.title3.bold())
                                        .foregroundColor(viewModel.textColor(book.rating))
                                    Text(book.author.name)
                                        .font(.headline.bold())
                                        .foregroundColor(.black.opacity(0.4))
                                }
                            }
                            .swipeActions {
                                Button {
                                    Task {
                                        await viewModel.delete(book)
                                    }
                                } label: {
                                    Text("Delete")
                                }
                                .tint(.red)
                                .accessibilityIdentifier("DeleteButton")
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Bookworm")
            .task {
                await viewModel.getBooks()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !viewModel.books.isEmpty {
                        EditButton()
                    }
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
                            viewModel.displayAddNewBook()
                        } label: {
                            Label("Add new Book", systemImage: "plus")
                        }
                        .accessibilityIdentifier("AddNewBookButton")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddNewBook) {
                AddNewBookView(manager: viewModel.manager)
            }
        }
    }
    
    init(manager: BooksMananger) {
        _viewModel = StateObject(wrappedValue: BooksViewModel(manager: manager))
    }
}
