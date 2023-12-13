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
    
    func getBooks() async -> [Book] { books }
    
    func addNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) async {
        let newBook = Book(title: title, authorName: authorName, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        books.append(newBook)
    }
    
    func deleteBook(_ book: Book) async {
        guard let selectedBook = books.firstIndex(of: book) else { return }
        books.remove(at: selectedBook)
    }
}
