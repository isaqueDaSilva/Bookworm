//
//  Book.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/11/23.
//

import Foundation

struct Book: Codable, Comparable, Equatable, Identifiable {
    var id = UUID()
    let title: String
    let author: Author
    let releaseDate: Date
    let genre: String
    let review: String
    let rating: Int
    
    var releaseDateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: releaseDate)
    }
    
    static let bookExemple = Book(title: UUID().uuidString, authorName: UUID().uuidString, releaseDate: Date.now, genre: UUID().uuidString, review: UUID().uuidString, rating: Int.random(in: 1...5))
    
    static var bookListExemples: [Book] {
        var bookList = [Book]()
        for _ in 0..<10 {
            let newBook = Book(title: UUID().uuidString, authorName: UUID().uuidString, releaseDate: Date.now, genre: UUID().uuidString, review: UUID().uuidString, rating: Int.random(in: 1...5))
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
    
    init(id: UUID = UUID(), title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) {
        self.id = id
        self.title = title
        self.author = Author(name: authorName)
        self.releaseDate = releaseDate
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}
