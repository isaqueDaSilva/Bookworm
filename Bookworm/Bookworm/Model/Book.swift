//
//  Book.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation
import SwiftData

@Model
final class Book: Codable {
    let id: UUID?
    var title: String
    let author: String
    var releaseDate: String
    var genre: String
    var review: String
    var rating: Int
    
    init(id: UUID? = nil, title: String, author: String, releaseDate: String, genre: String, review: String, rating: Int) {
        self.id = id
        self.title = title
        self.author = author
        self.releaseDate = releaseDate
        self.genre = genre
        self.review = review
        self.rating = rating
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case releaseDate = "release_date"
        case genre
        case review
        case rating
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(author, forKey: .author)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(genre, forKey: .genre)
        try container.encode(review, forKey: .review)
        try container.encode(rating, forKey: .rating)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.genre = try container.decode(String.self, forKey: .genre)
        self.review = try container.decode(String.self, forKey: .review)
        self.rating = try container.decode(Int.self, forKey: .rating)
    }
}
