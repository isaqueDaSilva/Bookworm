//
//  ContentView.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.savedBooks) { book in
                        NavigationLink {
                            DetailsView(book: book)
                        } label: {
                            HStack {
                                EmojiRating(rating: book.rating)
                                Text(book.wrappedTitle)
                                    .foregroundColor(viewModel.textColor(book.rating))
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteBook)
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button {
                        viewModel.showingAddNewBook = true
                    } label: {
                        Label("Add new Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddNewBook) {
                AddNewBookView()
            }
        }
    }
}
