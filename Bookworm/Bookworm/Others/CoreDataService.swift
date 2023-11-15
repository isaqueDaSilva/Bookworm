//
//  CoreDataService.swift
//  Bookworm
//
//  Created by Isaque da Silva on 14/11/23.
//

import Foundation
import CoreData

protocol CoreDataService {
    var container: NSPersistentContainer { get }
    var context: NSManagedObjectContext { get }
}
