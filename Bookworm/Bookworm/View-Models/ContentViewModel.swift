//
//  ContentViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/08/23.
//

import Foundation
import CoreData

class ContentViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var savedBook = [Book]()
    @Published var showingAddBookView = false
    
    func fetchBook() {
        let request = NSFetchRequest<Book>(entityName: "Book")
        
        do {
            savedBook = try container.viewContext.fetch(request)
        } catch let error {
            fatalError("Error to fetching Data. Error: \(error)")
        }
    }
    
    func saveBook() {
        do {
            try container.viewContext.save()
            fetchBook()
        } catch let error {
            fatalError("Error to save Data. Error: \(error)")
        }
    }
    
    func addBook(title: String, author: String, rating: Int, genre: String, review: String) {
        let newBook = Book(context: container.viewContext)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre = genre
        newBook.review = review
        saveBook()
    }
    
    func deleteBook(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let book = savedBook[index]
        container.viewContext.delete(book)
        saveBook()
    }
    
    func deleteCurrentBook(_ book: Book) {
        container.viewContext.delete(book)
        saveBook()
    }
    
    init() {
        container = NSPersistentContainer(name: "Bookworm")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Falied to load Data. Error: \(error)")
            }
        }
        fetchBook()
    }
}
