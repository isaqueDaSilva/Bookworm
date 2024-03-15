//
//  Storage.swift
//  Bookworm
//
//  Created by Isaque da Silva on 29/02/24.
//

import CoreData
import Foundation

/// A Storage object contains a default Core Data container 
/// and viewContext for uses in entire App.
final class Storage {
    let container: NSPersistentContainer
    var context: NSManagedObjectContext
    
    /// Save any changes that may occur.
    func save() throws {
        guard context.hasChanges else { return }
        try context.save()
    }
    
    /// Fetches a collection of any  of NSManagedObject saved.
    /// - Parameter request: A NSFetchRequest for perform a search for the NSManagedObject.
    /// - Returns: Returns an collection of any NSManagedObject.
    func fetch<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>) throws -> [T] {
        return try self.context.fetch(request)
    }
    
    /// Delete any NSManagedObject in Core Data.
    /// - Parameter model: Any NSManagedObject for perform a deletion in Core Data.
    func delete<M: NSManagedObject>(_ model: M) throws {
        self.context.delete(model)
        try self.save()
    }
    
    
    /// Initialize this object to use a unique Core Data container and viewContext throughout the application hierarchy.
    /// - Parameter inMemory: Indicates that will be used only memory for persist an object.
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "Book")
        self.context = self.container.viewContext
        
        if inMemory {
            self.container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        self.container.loadPersistentStores { _, error in
            if error != nil {
                print("Falied to loading Book entite.")
            }
        }
        
        self.context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
