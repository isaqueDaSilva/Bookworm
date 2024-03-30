//
//  Storage.swift
//  Bookworm
//
//  Created by Isaque da Silva on 29/02/24.
//

import CoreData
import Foundation

final class Storage {
    let container: NSPersistentContainer
    var context: NSManagedObjectContext
    
    func save() throws {
        guard context.hasChanges else { return }
        try context.save()
    }
   
    func fetch<T: NSFetchRequestResult>(
        _ fetchedResultController: NSFetchedResultsController<T>
    ) throws -> [T] {
        try fetchedResultController.performFetch()
        
        guard let object = fetchedResultController.fetchedObjects else {
            return []
        }
        
        return object
    }
    
    func fetchChanges<M: NSManagedObject>(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        by model: M.Type
    ) -> [M] {
        guard let models = controller.fetchedObjects as? [M] else { return [] }
        return models
    }
    
    func fetchedResultController<M: NSFetchRequestResult>(
        _ request: NSFetchRequest<M>
    ) -> NSFetchedResultsController<M> {
        NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
    
    func delete<M: NSManagedObject>(_ model: M) throws {
        self.context.delete(model)
        try self.save()
    }
    
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
