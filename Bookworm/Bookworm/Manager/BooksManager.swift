//
//  BooksManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation

class BooksMananger {
    let stack: CoreDataService
    var books: [Books]
    
    private func save() {
        do {
            try stack.context.save()
            fetchBooks()
        } catch let error {
            print("Falied to save book in Data Model. Error: \(error)")
        }
    }
    
    func fetchBooks() {
        let request = NSFetchRequest<Books>(entityName: "Books")
        
        do {
            self.books = try stack.context.fetch(request)
        } catch let error {
            print("Error to fetching Books in Core Data. Error: \(error)")
        }
    }
    
    func addNewBook(title: String, author: String, releaseDate: Date, genre: String, review: String, rating: Int) {
        let newBook = Books(context: stack.context)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = Author(context: stack.context)
        newBook.author?.name = author
        newBook.releaseDate = releaseDate
        newBook.genre = genre
        newBook.review = review
        newBook.rating = Int16(rating)
        save()
    }
    
    func delete(_ book: Books) {
        stack.context.delete(book)
        save()
    }
    
    init(stack: CoreDataService) {
        self.books = []
        self.stack = stack
    }
}
