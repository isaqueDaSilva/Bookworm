//
//  BookwormViewModel.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import CoreData
import Foundation

class BookwormViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var savedBooks = [Books]()
    
    func fetchBook() {
        let request = NSFetchRequest<Books>(entityName: "Books")
        
        do{
            savedBooks = try container.viewContext.fetch(request)
        } catch {
            fatalError("Falied to fetching books in Data Model. Error \(error)")
        }
    }
    
    func saveBook() {
        do {
            try container.viewContext.save()
            fetchBook()
        } catch {
            fatalError("Falied to save book in Data Model. Error: \(error)")
        }
    }
    
    func addBook(title: String, author: String, releaseData: Date, genre: String, review: String, rating: Int) {
        let newBook = Books(context: container.viewContext)
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.releaseData = releaseData
        newBook.genre = genre
        newBook.review = review
        newBook.rating = Int16(rating)
        saveBook()
    }
    
    func deleteBook(at indexSet: IndexSet) {
        guard let index = indexSet.first else {
            return
        }
        
        let book = savedBooks[index]
        container.viewContext.delete(book)
        saveBook()
    }
    
    func deleteCurrentBook(_ book: Books) {
        container.viewContext.delete(book)
        saveBook()
    }
    
    init() {
        container = NSPersistentContainer(name: "Bookworms")
        container.loadPersistentStores { (descripition, error) in
            if let error = error {
                fatalError("Falied to load book. Error: \(error)")
            }
        }
        fetchBook()
    }
}
