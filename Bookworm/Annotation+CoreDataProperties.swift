//
//  Annotation+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//
//

import Foundation
import CoreData


extension Annotation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Annotation> {
        return NSFetchRequest<Annotation>(entityName: "Annotation")
    }

    @NSManaged public var commentDescription: String?
    @NSManaged public var creation: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var lastModification: Date?
    @NSManaged public var title: String?
    @NSManaged public var book: Book?
    
    /// Returns the wrapped title of this Annotation.
    public var wrappedTitle: String {
        self.title ?? "No title saved"
    }
    
    /// Returns the wrapped comment description  of this Annotation.
    public var wrappedCommentDescription: String {
        self.commentDescription ?? "No comment saved."
    }
    
    /// Returns the wrapped the creation date of this Annotation.
    public var wrappedCreation: Date {
        self.creation ?? Date.now
    }
    
    /// Returns the wrapped last modification date of this Annotation.
    public var wrappedLastModification: Date {
        self.lastModification ?? Date.now
    }
}

extension Annotation : Identifiable {

}
