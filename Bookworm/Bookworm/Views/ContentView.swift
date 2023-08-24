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
                Text("Book count: \(books.count)")
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
