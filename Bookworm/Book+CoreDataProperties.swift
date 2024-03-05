//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 02/03/24.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var genre: String?
    @NSManaged public var review: String?
    @NSManaged public var rating: Int16
    @NSManaged public var startOfReading: Date?
    @NSManaged public var endOfReading: Date?
    @NSManaged public var isFinished: Bool
    @NSManaged public var creation: Date?
    @NSManaged public var isDisabled: Bool
    @NSManaged public var author: Author?
    @NSManaged public var annotations: NSSet?
    
    public var wrappedTitle: String {
        self.title ?? "No title saved."
    }
    
    public var wrappedAuthorName: String {
        self.author?.wrappedName ?? "No Author saved."
    }
    
    public var wrappedReleaseDare: Date {
        self.releaseDate ?? Date.now
    }
    
    public var wrappedGenre: String {
        self.genre ?? "No genre saved."
    }
    
    public var wrappedReview: String {
        self.review ?? "No review saved."
    }
    
    public var wrappedStartOfReading: Date {
        self.startOfReading ?? Date.now
    }
    
    public var wrappedEndOfReading: Date {
        self.endOfReading ?? Date.now
    }
    
    public var wrappedCreation: Date {
        self.creation ?? Date.now
    }
    
    public var wrappedAnnotations: [Annotation] {
        let list = annotations as? Set<Annotation> ?? []
        return list.sorted { $0.wrappedCreation < $1.wrappedCreation }
    }
}

// MARK: Generated accessors for annotations
extension Book {

    @objc(addAnnotationsObject:)
    @NSManaged public func addToAnnotations(_ value: Annotation)

    @objc(removeAnnotationsObject:)
    @NSManaged public func removeFromAnnotations(_ value: Annotation)

    @objc(addAnnotations:)
    @NSManaged public func addToAnnotations(_ values: NSSet)

    @objc(removeAnnotations:)
    @NSManaged public func removeFromAnnotations(_ values: NSSet)

}

extension Book : Identifiable {

}
