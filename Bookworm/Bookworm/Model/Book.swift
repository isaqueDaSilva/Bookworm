//
//  Book.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation
import SwiftData

@Model
final class Book {
    @Attribute(.unique)
    let id: UUID
    
    @Attribute(.unique)
    var title: String
    
    var author: Author
    var releaseDate: Date
    var genre: Genre
    
    var review = ""
    var rating: Int
    
    @Relationship(deleteRule: .cascade)
    var notes = [Annotation]()
    
    var startOfReading: Date
    var endOfReading: Date? = nil
    
    let creation = Date.now
    
    var isDisabled = false
    
    init(
        id: UUID,
        title: String,
        author: Author,
        releaseDate: Date,
        genre: Genre,
        rating: Int,
        startOfReading: Date
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.releaseDate = releaseDate
        self.genre = genre
        self.rating = rating
        self.startOfReading = startOfReading
    }
}

extension Book: Hashable { }
