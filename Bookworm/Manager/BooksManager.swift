//
//  BooksManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation

actor BooksMananger {
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    var books: [Books]
    
    private func save() {
        do {
            try context.save()
            fetchBooks()
        } catch let error {
            print("Falied to save book in Data Model. Error: \(error)")
        }
    }
    
    func fetchBooks() {
        let request = NSFetchRequest<Books>(entityName: "Books")
        
        do {
            self.books = try context.fetch(request)
        } catch let error {
            print("Error to fetching Books in Core Data. Error: \(error)")
        }
    }
    
    func addNewBook(title: String, author: String, releaseDate: Date, genre: String, review: String, rating: Int) {
        let newBook = Books(context: context)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = Author(context: context)
        newBook.author?.name = author
        newBook.releaseDate = releaseDate
        newBook.genre = genre
        newBook.review = review
        newBook.rating = Int16(rating)
        save()
    }
    
    func delete(_ book: Books) {
        context.delete(book)
        save()
    }
    
    init() {
        self.books = []
        
        self.container = NSPersistentContainer(name: "Bookworm")
        self.context = container.viewContext
        
        self.container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Falied to load book. Error: \(error)")
            }
        }
        
        self.context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }
}
