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
