//
//  BooksManagerForTest.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 03/12/23.
//

@testable import Bookworm
import Foundation

actor BooksManagerForTest: DataServiceProtocol {
    private var books = [Book]()
    
    func getBooks() async -> [Book] {
        return books
    }
    
    func addNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) async {
        let newBook = Book(title: title, author: Author(name: authorName), releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        self.books.append(newBook)
    }
    
    func delete(_ book: Book) async {
        guard let bookIndex = self.books.firstIndex(of: book) else { return }
        self.books.remove(at: bookIndex)
    }
}
