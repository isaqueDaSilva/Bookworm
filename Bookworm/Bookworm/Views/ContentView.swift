//
//  ContentView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/08/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @StateObject var viewModel = ContentView.ContentViewViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: {
                        Text(book.title ?? "Unknown Title")
                    }, label: {
                        HStack {
                            EmojiRating(rating: book.rating)
                            Text(book.title ?? "Unknown Title")
                        }
                    })
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                Button(action: {
                    viewModel.showingAddBookView.toggle()
                }, label: {
                    Label("Add New Book", systemImage: "plus")
                })
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
