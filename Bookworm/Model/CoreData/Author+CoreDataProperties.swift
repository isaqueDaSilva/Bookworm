//
//  Author+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
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

extension Author : Identifiable {

}

// MARK: Wrapping model informations.
extension Author {
    public var wrappedName: String {
        self.name ?? "No name saved."
    }
    
    public var wrappedBooks: [Book] {
        let list = books as? Set<Book> ?? []
        let books = list.sorted { $0.wrappedCreateAt < $1.wrappedCreateAt }
        
        return books
    }
}

// MARK: - Custom Initialize -

extension Author {
    convenience init(
        context: NSManagedObjectContext,
        name: String
    ) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.books = []
    }
}

#if DEBUG
// MARK: - Preview Data -
extension Author {
    static func makePreview(withContext context: NSManagedObjectContext) -> Author {
        Author(context: context, name: "Author \(Int.random(in: 1...100))")
    }
}

#endif
