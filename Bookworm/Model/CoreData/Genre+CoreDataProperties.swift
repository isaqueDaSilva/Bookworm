//
//  Genre+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension Genre {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension Genre : Identifiable {

}

// MARK: Wrapping model informations.
extension Genre {
    public var wrappedName: String {
        self.name ?? "No name saved"
    }
    
    public var wrappedBooks: [Book] {
        let list = books as? Set<Book> ?? []
        let books = list.sorted(by: { $0.wrappedCreateAt < $1.wrappedCreateAt })
        
        return books
    }
}

// MARK: - Custom initializer -
extension Genre {
    convenience init(context: NSManagedObjectContext, name: String) {
        self.init(context: context)
        self.name = name
        self.books = []
    }
}

#if DEBUG
extension Genre {
    static func makePreview(withContext context: NSManagedObjectContext) -> Genre {
        Genre(context: context, name: "Genre \(Int.random(in: 1...100))")
    }
}
#endif
