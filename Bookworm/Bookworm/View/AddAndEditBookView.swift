//
//  AddNewBookView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct AddAndEditBookView: View {
    @StateObject private var viewModel: AddAndEditBookViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                Form {
                    Section {
                        BookCover(width: 135, height: 180, customText: "T")
                        .listRowBackground(Color(CGColor(red: 240, green: 240, blue: 246, alpha: 0)))
                    }
                    .frame(width: geo.size.width)
                    
                    Section("Book's information") {
                        TextField("Insert the Book's title...", text: $viewModel.title)
                        
                        HStack(alignment: .center) {
                            Text("Author:")
                            Spacer()
                            Text(viewModel.authorName)
                                .foregroundStyle(.secondary)
                        }
                        DatePicker("Release date:", selection: $viewModel.releaseDate, in: ...Date.now, displayedComponents: .date)
                        Picker("Book's genre:", selection: $viewModel.genre) {
                            ForEach(Genre.allCases, id: \.rawValue) {
                                Text($0.rawValue)
                            }
                        }
                        
                        HStack {
                            Text("Rating:")
                            Spacer()
                            RatingStars(rating: $viewModel.rating)
                        }
                    }
                    
                    Section("Review") {
                        TextEditor(text: $viewModel.review)
                    }
                }
                .navigationTitle("Add new Book")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton { 
                            dismiss()
                        }
                    }
                    
                    ToolbarItem {
                        SaveButton { 
                            Task {
                                try await viewModel.createNewBook()
                            }
                        }
                    }
                }
            }
        }
    }
    
    init(author: UUID, authenticator: AuthenticationManager) {
        _viewModel = StateObject(wrappedValue: AddAndEditBookViewModel(authenticationManager: authenticator, author: author))
    }
    
    init(authenticator: AuthenticationManager, author: UUID, book: Book) {
        _viewModel = StateObject(wrappedValue: AddAndEditBookViewModel(authenticationManager: authenticator, author: author, book: book))
    }
}

//#Preview {
//    AddNewBookView()
//}
