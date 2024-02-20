//
//  User.swift
//  Bookworm
//
//  Created by Isaque da Silva on 16/02/24.
//

import Foundation
import SwiftData

/// A representation of an user data.
@Model
final class User: Identifiable {
    /// An unique identifier for user.
    let id: UUID
    
    /// Name of user.
    let name: String
    
    /// Username of user.
    var username: String
    
    /// Email of user.
    let email: String
    
    /// Authors that the user has saved
    var authors: [Author]
    
    /// The books that the user has saved linked to each author they have saved.
    var books = [Book]()
    
    /// Creates a new instance for user.
    init(
        id: UUID,
        name: String,
        username: String,
        email: String,
        authors: [Author]
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.authors = authors
        
        authors.forEach { author in
            author.books.forEach { book in
                if !self.books.contains(book) {
                    self.books.append(book)
                }
            }
        }
    }
}

// A mapping from a user's items
// obtained from a request
// to the user's items in SwiftData.
extension User {
    /// Creates a new user instance from a decoded result from server.
    convenience init(from result: Result) {
        self.init(
            id: result.id,
            name: result.name,
            username: result.username,
            email: result.email,
            authors: result.authors.convertResultCollectionInAuthors()
        )
    }
}


extension User {
    /// Update an existent user from a decoded result from server.
    func update(_ userResult: Result) {
        self.username = userResult.username
        self.authors = userResult.authors.convertResultCollectionInAuthors()
        
        var booksResult = [Result.BookResult]()
        
        userResult.authors.forEach { author in
            author.books.forEach { book in
                booksResult.append(book)
            }
        }
        
        self.books = booksResult.convertResultCollectionInBooks()
    }
}
