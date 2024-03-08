//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 08/03/24.
//
//

import Foundation
import CoreData
import UIKit


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var creation: Date?
    @NSManaged public var endOfReading: Date?
    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isFinished: Bool
    @NSManaged public var rating: Int16
    @NSManaged public var releaseDate: Date?
    @NSManaged public var review: String?
    @NSManaged public var startOfReading: Date?
    @NSManaged public var title: String?
    @NSManaged public var cover: Data?
    @NSManaged public var annotations: NSSet?
    @NSManaged public var author: Author?
    
    public var wrappedTitle: String {
        self.title ?? "No title saved."
    }
    
    public var wrappedAuthorName: String {
        self.author?.wrappedName ?? "No Author saved."
    }
    
    public var coverImage: UIImage? {
        guard let imageData = self.cover else {
            return nil
        }
        
        return UIImage(data: imageData)
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
