//
//  Book.swift
//  Bookworm
//
//  Created by Isaque da Silva on 16/02/24.
//

import Foundation

/// A representation of a book data.
final class Book: Identifiable {
    /// An unique identifier for book.
    let id: UUID
    
    /// Book title.
    var title: String
    
    /// Name of the book's author
    var authorName: String
    
    /// When the book was released
    var releaseDate: String
    
    /// Genre to which the book belongs.
    var genre: String
    
    /// A brief review text that the user gave to the book
    var review: String
    
    /// Rating of 1-5 that the user submitted to the book.
    var rating: Int
    
    /// Creates a new instance for book.
    init(id: UUID, title: String, authorName: String, releaseDate: String, genre: String, review: String, rating: Int) {
        self.id = id
        self.title = title
        self.authorName = authorName
        self.releaseDate = releaseDate
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}

// Makes the book class to conform to the Codable protocol.
extension Book: Codable { }

// A mapping from a book's items
// obtained from a request
// to the book's items in SwiftData.
extension Book {
    
    /// Creates a new author instance from a decoded result from server.
    convenience init(from result: Result.BookResult) {
        self.init(
            id: result.id,
            title: result.title,
            authorName: result.authorName,
            releaseDate: result.releaseDate,
            genre: result.genre,
            review: result.review,
            rating: result.rating
        )
    }
}

// Makes the book class to conform to the Hashable protocol.
extension Book: Hashable {
    
    // Compare the left book item
    // with the right book item
    // and return the true if both are same
    // or false if one is not the same as the other.
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    // Transform the id into hash value.
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
