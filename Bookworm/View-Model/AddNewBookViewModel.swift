//
//  AddNewBookViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation

extension AddNewBookView {
    class AddNewBookViewModel: ObservableObject {
        let manager = CoreDataMananger.shared
        
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
            let newBook = Books(context: manager.context)
            newBook.id = UUID()
            newBook.title = title
            newBook.author = Author(context: manager.context)
            newBook.author?.name = author
            newBook.releaseDate = releaseDate
            newBook.genre = genre
            newBook.review = review
            newBook.rating = Int16(rating)
            manager.save()
        }
    }
}
