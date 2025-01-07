//
//  Annotation+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//
//

import Foundation
import CoreData


extension Annotation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Annotation> {
        return NSFetchRequest<Annotation>(entityName: "Annotation")
    }

    @NSManaged public var commentDescription: String?
    @NSManaged public var createAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var lastModification: Date?
    @NSManaged public var title: String?
    @NSManaged public var book: Book?

}

extension Annotation : Identifiable { }

extension Annotation {
    convenience init(
        context: NSManagedObjectContext,
        title: String,
        commentDescription: String,
        book: Book
    ) {
        self.init(context: context)
        
        self.id = UUID()
        self.title = title
        self.commentDescription = commentDescription
        self.book = book
        self.createAt = .now
        self.lastModification = .now
    }
}

// MARK: Wrapping model informations.
extension Annotation {
    public var wrappedTitle: String {
        self.title ?? "No title saved"
    }
    
    public var wrappedCommentDescription: String {
        self.commentDescription ?? "No comment saved."
    }
    
    public var wrappedCreateAt: Date {
        self.createAt ?? Date.now
    }
    
    public var wrappedLastModification: Date {
        self.lastModification ?? Date.now
    }
}

#if DEBUG
// MARK: - Preview Data -
extension Annotation {
    static func makePreview(
        withContext context: NSManagedObjectContext,
        book: Book
    ) -> Annotation {
        Annotation(
            context: context,
            title: "Annotation for \(book.wrappedTitle) \(Int.random(in: 1...100))",
            commentDescription: "Description for \(book.wrappedTitle) \(Int.random(in: 1...100))",
            book: book
        )
    }
}
#endif
