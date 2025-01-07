//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//
//

import Foundation
import CoreData
import UIKit

extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var cover: Data?
    @NSManaged public var createAt: Date?
    @NSManaged public var endOfReading: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isFinished: Bool
    @NSManaged public var rating: Int16
    @NSManaged public var releaseDate: Date?
    @NSManaged public var review: String?
    @NSManaged public var startOfReading: Date?
    @NSManaged public var title: String?
    @NSManaged public var annotations: NSSet?
    @NSManaged public var author: Author?
    @NSManaged public var genre: Genre?

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

// MARK: Wrapping model informations.
extension Book {
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
    
    public var wrappedReleaseDate: Date {
        self.releaseDate ?? Date.now
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
    
    public var wrappedCreateAt: Date {
        self.createAt ?? .now
    }
    
    public var wrappedAnnotations: [Annotation] {
        let list = annotations as? Set<Annotation> ?? []
        let annotations = list.sorted { $0.wrappedCreateAt < $1.wrappedCreateAt }
        
        return annotations
    }
    
    public var wrappedGenre: String {
        genre?.wrappedName ?? "No Genre Saved"
    }
    
    public var overlayColor: UIColor {
        if isFinished {
            
            switch Int(rating) {
            case 1...2:
                return .red
            case 3...4:
                return .orange
            case 5:
                return .green
            default:
                return .white
            }
        } else {
            return .white
        }
    }
}

// MARK: - Custom Initialize -
extension Book {
    convenience init(
        context: NSManagedObjectContext,
        title: String,
        author: Author,
        genre: Genre,
        cover: Data?,
        releaseDate: Date,
        startOfReading: Date,
        isFinished: Bool,
        endOfReading: Date?,
        rating: Int?,
        review: String?
    ) {
        self.init(context: context)
        self.id = UUID()
        self.title = title
        self.author = author
        self.genre = genre
        self.cover = cover
        self.releaseDate = releaseDate
        self.startOfReading = startOfReading
        self.isFinished = isFinished
        self.endOfReading = endOfReading
        
        if let rating {
            self.rating = Int16(rating)
        } else {
            self.rating = 0
        }
        
        self.review = review
        self.annotations = []
        
        self.createAt = .now
    }
}

#if DEBUG
// MARK: - Preview Data -
extension Book {
    static func makePreview(
        withContext context: NSManagedObjectContext,
        author: Author,
        genre: Genre
    ) -> Book {
        let isFinished = Bool.random()
        let coverImage = UIImage(systemName: "book.fill")
        
        return Book(
            context: context,
            title: "Book \(Int.random(in: 1...100))",
            author: author,
            genre: genre,
            cover: coverImage?.pngData(),
            releaseDate: .now,
            startOfReading: .now,
            isFinished: isFinished,
            endOfReading: isFinished ? .now : nil,
            rating: isFinished ? .random(in: 1...5) : nil,
            review: isFinished ? "Review \(Int.random(in: 1...100))" : nil
        )
    }
}
#endif
