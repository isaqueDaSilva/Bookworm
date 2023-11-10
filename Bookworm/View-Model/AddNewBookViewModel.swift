//
//  AddNewBookViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

extension AddNewBookView {
    class AddNewBookViewModel: ObservableObject {
        let manager: BooksMananger
        
        @Published var title = ""
        @Published var author = ""
        @Published var releaseDate = Date.now
        @Published var genre = "Fantasy"
        @Published var review = ""
        @Published var rating = 1
        @Published var showingAlert = false
        
        let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
        
        var isValid: Bool {
            if title.isEmpty || author.isEmpty || review.isEmpty {
                return false
            } else {
                return true
            }
        }
        
        func addBook() {
            Task { @MainActor in 
                await manager.addNewBook(title: title, author: author, releaseDate: releaseDate,genre: genre, review: review,rating: rating)
            }
        }
        
        init(manager: BooksMananger) {
            self.manager = manager
        }
    }
}
