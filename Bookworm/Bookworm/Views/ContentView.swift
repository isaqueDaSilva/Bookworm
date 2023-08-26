//
//  ContentView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.savedBook) { book in
                    NavigationLink(destination: {
                        DetailView(book: book)
                    }, label: {
                        HStack {
                            EmojiRating(rating: book.rating)
                            Text(book.title ?? "Unknown Title")
                        }
                    })
                }
                .onDelete(perform: viewModel.deleteBook)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action: {
                        viewModel.showingAddBookView.toggle()
                    }, label: {
                        Label("Add New Book", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $viewModel.showingAddBookView) {
                AddNewBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
