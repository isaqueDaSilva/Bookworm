//
//  BooksManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation

actor BooksMananger {
    var books: [Book]
    var path: URL
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(self.books)
            try data.write(to: path, options: [.atomic, .completeFileProtection])
        } catch let error {
            print("Falied to save data in FileManager. Error: \(error)")
        }
    }
    
    func fetchBooks() {
        do {
            let data = try Data(contentsOf: path)
            let booksDecoded = try JSONDecoder().decode([Book].self, from: data)
            self.books = booksDecoded
        } catch let error {
            self.books = []
            print("Falied to fetch data in File Manager. Error: \(error)")
        }
    }
    
    func addNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) {
        let newBook = Book(title: title, author: Author(name: authorName), releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        guard !books.contains(newBook) else { return }
        books.append(newBook)
        save()
    }
    
    func delete(_ book: Book) {
        guard let selectedBook = books.firstIndex(of: book) else { return }
        books.remove(at: selectedBook)
        save()
    }
    
    func addBookForTest() {
        self.books.append(Book.bookExemple)
        save()
    }
    
    func addBookListForTest() {
        self.books = Book.bookListExemples
        save()
    }
    
    func removeAllBooksForTest() {
        self.books.removeAll()
        self.save()
    }
    
    init(path: URL) {
        self.books = []
        self.path = path
    }
}
