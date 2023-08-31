//
//  CoreDataManager.swift
//  Bookworms
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    func saveBook() {
        do {
            try context.save()
        } catch let error {
            fatalError("Falied to save book in Data Model. Error: \(error)")
        }
    }
    
    init() {
        container = NSPersistentContainer(name: "Bookworm")
        container.loadPersistentStores { (descripition, error) in
            if let error = error {
                fatalError("Falied to load book. Error: \(error)")
            }
        }
        context = container.viewContext
    }
}
