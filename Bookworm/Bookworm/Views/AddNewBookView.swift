//
//  AddNewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/08/23.
//

import SwiftUI

struct AddNewBookView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddNewBookViewModel()
    @ObservedObject var contentViewModel = ContentViewModel()
    var body: some View {
        NavigationView {
            Form {
                Section("Book Information:") {
                    TextField("Title of Book...", text: $viewModel.title)
                    TextField("Author's Name...", text: $viewModel.author)
                    
                    Picker("Genre", selection: $viewModel.genre) {
                        ForEach(viewModel.genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Book Review:") {
                    Rating(rating: $viewModel.rating)
                    
                    ZStack {
                        if viewModel.review.count == 0 {
                            Text("Write a review for the book...")
                                .font(.system(size: 17))
                                .foregroundColor(.black.opacity(0.225))
                                .frame(maxWidth: .infinity)
                        }
                        TextEditor(text: $viewModel.review)
                    }
                }
            }
            .navigationTitle("Add New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    })
                }
            }
            .toolbar {
                Button("Save") {
                    contentViewModel.addBook(title: viewModel.title, author: viewModel.author, rating: viewModel.rating, genre: viewModel.genre, review: viewModel.review)
                    dismiss()
                }
            }
        }
    }
}

struct AddNewBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewBookView()
    }
}
