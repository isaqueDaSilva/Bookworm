//
//  Books+CoreDataProperties.swift
//  Bookworms
//
//  Created by Isaque da Silva on 28/08/23.
//
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books")
    }

    @NSManaged public var author: String?
    @NSManaged public var genre: String?
    @NSManaged public var id: UUID?
    @NSManaged public var rating: Int16
    @NSManaged public var releaseData: Date?
    @NSManaged public var review: String?
    @NSManaged public var title: String?
    
    public var wrappedTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedAuthor: String {
        author ?? "Unknown Author"
    }
    
    public var wrappedGenre: String {
        genre ?? "Fantasy"
    }
    
    public var wrappedReleaseDate: Date {
        releaseData ?? Date.now
    }
    
    public var wrappedReview: String {
        review ?? "No Review"
    }

}

extension Books : Identifiable {

}
