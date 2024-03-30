//
//  Author+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/03/24.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var books: NSSet?

    
    public var wrappedName: String {
        self.name ?? "No name saved."
    }
    
    public var wrappedBooks: [Book] {
        let list = books as? Set<Book> ?? []
        return list.sorted { $0.wrappedCreation < $1.wrappedCreation }
    }
}

// MARK: Generated accessors for books
extension Author {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension Author : Identifiable { }
