//
//  CoreDataManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation

class CoreDataMananger {
    static let shared = CoreDataMananger()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    func save() {
        do {
            try context.save()
        } catch let error {
            fatalError("Falied to save book in Data Model. Error: \(error)")
        }
    }
    
    init() {
        container = NSPersistentContainer(name: "Bookworm")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Falied to load book. Error: \(error)")
            }
        }
        context = container.viewContext
    }
}
