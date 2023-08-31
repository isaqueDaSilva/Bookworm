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

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var genre: String?
    @NSManaged public var rating: Int16
    @NSManaged public var review: String?
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedAuthor: String {
        author ?? "Unknown Author"
    }
    
    public var wrappedReleaseDate: Date {
        releaseDate ?? Date.now
    }
    
    public var wrappedGenre: String {
        genre ?? "Unknown Genre"
    }
    
    public var wrappedReview: String {
        review ?? "No Review"
    }
}

extension Books : Identifiable {

}
