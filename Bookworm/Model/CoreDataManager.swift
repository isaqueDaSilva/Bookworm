//
//  CoreDataManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation

class CoreDataMananger: ObservableObject {
    static let shared = CoreDataMananger()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    var books = [Books]()
    
    func fetchBooks() {
        let request = NSFetchRequest<Books>(entityName: "Books")
        
        do {
            books = try context.fetch(request)
        } catch let error {
            fatalError("Falied to fetching books in Data Model. Error \(error)")
        }
    }
    
    func save() {
        do {
            try context.save()
            fetchBooks()
        } catch let error {
            fatalError("Falied to save book in Data Model. Error: \(error)")
        }
    }
    
    init() {
        container = NSPersistentContainer(name: "Bookworm")
        context = container.viewContext
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Falied to load book. Error: \(error)")
            }
            self.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
