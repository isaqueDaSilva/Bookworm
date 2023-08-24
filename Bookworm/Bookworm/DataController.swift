//
//  DataController.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/08/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Falied to load Data\nError: \(error.localizedDescription)")
            }
        }
    }
}
