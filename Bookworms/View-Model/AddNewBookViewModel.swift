//
//  AddNewBookViewModel.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import CoreData
import Foundation

extension AddNewBookView {
    class AddNewBookViewModel: ObservableObject {
        let manager = CoreDataManager.shared
        
        @Published var title = ""
        @Published var author = ""
        @Published var releaseData = Date.now
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
            let newBook = Book(context: manager.context)
            newBook.id = UUID()
            newBook.title = title
            newBook.author = author
            newBook.releaseData = releaseData
            newBook.genre = genre
            newBook.review = review
            newBook.rating = Int16(rating)
            manager.saveBook()
        }
    }
}
