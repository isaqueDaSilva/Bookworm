//
//  ContentView.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bookwormViewModel = BookwormViewModel()
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(bookwormViewModel.savedBooks) { book in
                        NavigationLink {
                            DetailsView(bookwormViewModel: bookwormViewModel, book: book)
                        } label: {
                            HStack {
                                EmojiRating(rating: book.rating)
                                Text(book.title ?? "")
                                    .foregroundColor(viewModel.textColor(book.rating))
                            }
                        }
                    }
                    .onDelete(perform: bookwormViewModel.deleteBook)
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
                AddNewBookView(bookwormViewModel: bookwormViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
