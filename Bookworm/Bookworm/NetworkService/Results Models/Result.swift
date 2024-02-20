//
//  UserResult.swift
//  Bookworm
//
//  Created by Isaque da Silva on 16/02/24.
//

import Foundation

/// A container that decodes a user data from the server.
///
/// This structure decodes JSON with the following layout:
///
/// ```json
/// {
///    "id": "",
///    "name": "",
///    "username": ""
///    "email": ""
///    "authors": [
///        {
///            "id": "",
///            "authorName": "",
///            "book": [
///                 {
///                     "id": "",
///                     "title": "",
///                     "authorName": "",
///                     "releaseDate": "",
///                     "genre": "",
///                     "review": "",
///                     "rating": 5
///                 }
///            ]
///        }
///    ]
/// }
/// ```
///
struct Result: Decodable {
    let id: UUID
    let name: String
    let username: String
    let email: String
    let authors: [AuthorResult]
}

// Models Representations of Authors and Books
extension Result {
    struct AuthorResult: Decodable {
        let id: UUID
        let authorName: String
        let books: [BookResult]
    }
    
    struct BookResult: Decodable {
        let id: UUID
        let title: String
        let authorName: String
        let releaseDate: String
        let genre: String
        let review: String
        let rating: Int
    }
}
