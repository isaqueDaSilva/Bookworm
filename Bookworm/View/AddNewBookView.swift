//
//  AddNewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct AddNewBookView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddNewBookViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section("About the Book") {
                    TextField("Book Title", text: $viewModel.title)
                    TextField("Author", text: $viewModel.author)
                    DatePicker("Release Data", selection: $viewModel.releaseDate, in: ...Date.now, displayedComponents: .date)
                    Picker("Genre", selection: $viewModel.genre) {
                        ForEach(viewModel.genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Review") {
                    RatingStars(rating: $viewModel.rating)
                    
                    ZStack(alignment: .leading) {
                        if viewModel.review.isEmpty {
                            Text("What did you think about the book?")
                                .font(.subheadline)
                                .foregroundColor(.secondary.opacity(0.6))
                                .padding(.horizontal, 3)
                        }
                        TextEditor(text: $viewModel.review)
                    }
                }
            }
            .navigationTitle("Add New Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.isValid {
                    ToolbarItem {
                        Button("OK") {
                            viewModel.addBook()
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
        }
    }
    
    init(manager: BooksMananger) {
        _viewModel = StateObject(wrappedValue: AddNewBookViewModel(manager: manager))
    }
}
