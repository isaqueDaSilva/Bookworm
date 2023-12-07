//
//  BooksManager.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

actor BooksMananger: DataServiceProtocol {
    @Published private var books = [Book]()
    
    private var path: URL
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(self.books)
            try data.write(to: self.path, options: [.atomic, .completeFileProtection])
            self.fetchBooks()
        } catch let error {
            print("Falied to save data in FileManager. Error: \(error)")
        }
    }
    
    private func fetchBooks() {
        do {
            let data = try Data(contentsOf: path)
            let booksDecoded = try JSONDecoder().decode([Book].self, from: data)
            self.books = booksDecoded
        } catch let error {
            self.books = []
            print("Falied to fetch Books in File Manager. Error: \(error)")
        }
    }
    
    func getBooks() -> Published<[Book]>.Publisher {
        self.fetchBooks()
        return $books
    }
    
    func addNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) {
        let newBook = Book(title: title, author: Author(name: authorName), releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        guard !books.contains(newBook) else { return }
        self.books.append(newBook)
        self.save()
    }
    
    func delete(_ book: Book) {
        guard let selectedBook = books.firstIndex(of: book) else { return }
        self.books.remove(at: selectedBook)
        self.save()
    }
    
    init(path: URL) {
        self.path = path
    }
}
