//
//  Book.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/11/23.
//

import Foundation

struct Book: Codable, Identifiable, Equatable, Comparable {
    var id = UUID()
    let title: String
    let author: Author
    let releaseDate: Date
    let genre: String
    let review: String
    let rating: Int
    
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    static let bookExemple = Book(title: UUID().uuidString, author: Author(name: UUID().uuidString), releaseDate: Date.now, genre: "Fantasy", review: UUID().uuidString, rating: Int.random(in: 1...5))
    
    static var bookListExemples: [Book] {
        var bookList = [Book]()
        for _ in 0..<10 {
            let newBook = Book(title: UUID().uuidString, author: Author(name: UUID().uuidString), releaseDate: Date.now, genre: "Fantasy", review: UUID().uuidString, rating: Int.random(in: 1...5))
            bookList.append(newBook)
        }
        
        return bookList
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.title == rhs.title
    }
    
    static func < (lhs: Book, rhs: Book) -> Bool {
        lhs.title < rhs.title
    }
}
