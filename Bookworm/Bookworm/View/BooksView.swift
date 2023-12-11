//
//  BooksView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct BooksView: View {
    @StateObject var viewModel = BooksViewModel()
    @EnvironmentObject var dataManager: BooksData
    
    var body: some View {
        NavigationView {
            List {
                if dataManager.showingPicker {
                    Picker("Select", selection: $dataManager.text) {
                        ForEach(dataManager.choiceText, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    ForEach(dataManager.search) { book in
                        NavigationLink {
                            BookDetailsView(book: book)
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
                                        await dataManager.deleteBook(book)
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
                await dataManager.loadBooks()
            }
            .toolbar {
                ToolbarItem {
                    HStack {
                        Menu {
                            Picker("Filter", selection: $dataManager.filter) {
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
                AddNewBookView()
            }
        }
        .environmentObject(dataManager)
    }
}
