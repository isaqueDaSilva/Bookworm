//
//  AddNewBookViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

class AddNewBookViewModel: ObservableObject {
    let manager: BooksMananger
    
    private var onSave: () async -> Void
    
    @Published var title = ""
    @Published var author = ""
    @Published var releaseDate = Date.now
    @Published var genre = "Fantasy"
    @Published var review = ""
    @Published var rating = 1
    @Published var showingAlert = false
    
    var isValid: Bool {
        if title.isEmpty || author.isEmpty || review.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    func addBook() async {
        await manager.addNewBook(title: title, authorName: author, releaseDate: releaseDate,genre: genre, review: review,rating: rating)
        await self.onSave()
    }
    
    init(manager: BooksMananger, onSave: @escaping () async -> Void) {
        self.manager = manager
        self.onSave = onSave
    }
}
