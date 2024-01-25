//
//  Book.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/11/23.
//

import Foundation

struct Book: Codable, Identifiable {
    let id: UUID
    let title: String
    let author: UUID
    let releaseDate: String
    let genre: Genre.RawValue
    let review: String
    let rating: Int
}

extension Book {
    struct CreateBook: Codable {
        let title: String
        let author: UUID
        let releaseDate: String
        let genre: Genre.RawValue
        let review: String
        let rating: Int
    }
}

extension Book {
    struct UpdateBook: Codable {
        let title: String?
        let releaseDate: String?
        let genre: Genre.RawValue?
        let review: String?
        let rating: Int?
    }
}
