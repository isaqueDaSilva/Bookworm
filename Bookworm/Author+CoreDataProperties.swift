//
//  Author+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var name: String?
    @NSManaged public var book: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var booksArray: [Books] {
        let set = book as? Set<Books> ?? []
        return set.sorted { $0.wrappedTitle < $1.wrappedTitle }
    }
}

// MARK: Generated accessors for book
extension Author {

    @objc(addBookObject:)
    @NSManaged public func addToBook(_ value: Books)

    @objc(removeBookObject:)
    @NSManaged public func removeFromBook(_ value: Books)

    @objc(addBook:)
    @NSManaged public func addToBook(_ values: NSSet)

    @objc(removeBook:)
    @NSManaged public func removeFromBook(_ values: NSSet)

}

extension Author : Identifiable {

}
