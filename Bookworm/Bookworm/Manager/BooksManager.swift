//
//  BooksManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

actor BooksManager: DataServiceProtocol {
    private let url: URL
    private var books = [Book]()
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(self.books)
            try data.write(to: url, options: [.atomic, .completeFileProtection])
        } catch let error {
            print("Falied to save data in FileManager. Error: \(error)")
        }
    }
    
    private func fetchBooks() {
        do {
            let data = try Data(contentsOf: url)
            self.books = try JSONDecoder().decode([Book].self, from: data)
        } catch let error {
            self.books = []
            print("Falied to fetch data to FileManager. Error: \(error)")
        }
    }
    
    func getBooks() -> [Book] {
        self.fetchBooks()
        return books
    }
    
    func addNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) {
        let newBook = Book(title: title, authorName: authorName, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        guard !books.contains(newBook) else { return }
        books.append(newBook)
        self.save()
    }
    
    func deleteBook(_ book: Book) {
        guard let selectedBook = books.firstIndex(of: book) else { return }
        books.remove(at: selectedBook)
        self.save()
    }
    
    init(url: URL) {
        self.url = url
    }
}
