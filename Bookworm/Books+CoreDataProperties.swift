//
//  Books+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books")
    }

    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var rating: Int16
    @NSManaged public var releaseDate: Date?
    @NSManaged public var review: String?
    @NSManaged public var title: String?
    @NSManaged public var author: Author?
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedGenre: String {
        genre ?? "Unknown Genre"
    }
    
    public var wrappedReleaseDate: Date {
        releaseDate ?? Date.now
    }
    
    public var wrappedReview: String {
        title ?? "No Review"
    }
}

extension Books : Identifiable {

}
