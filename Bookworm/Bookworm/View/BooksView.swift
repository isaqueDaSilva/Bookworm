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
                            BookDetailsView(manager: viewModel.manager, book: book, onChange: viewModel.getBooks)
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
                        }
                        
                    }
                    .onDelete(perform: viewModel.delete)
                }
                .listStyle(.plain)
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
                            viewModel.displayAddNewBook()
                        } label: {
                            Label("Add new Book", systemImage: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddNewBook) {
                AddNewBookView(manager: viewModel.manager, onSave: viewModel.getBooks)
            }
        }
    }
    
    init(manager: BooksMananger) {
        _viewModel = StateObject(wrappedValue: BooksViewModel(manager: manager))
    }
}
