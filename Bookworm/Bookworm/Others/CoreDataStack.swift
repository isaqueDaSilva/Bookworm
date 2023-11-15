//
//  CoreDataStack.swift
//  Bookworm
//
//  Created by Isaque da Silva on 14/11/23.
//

import Foundation
import CoreData

class CoreDataStack: CoreDataService {
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
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
