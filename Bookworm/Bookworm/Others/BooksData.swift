//
//  BooksData.swift
//  Bookworm
//
//  Created by Isaque da Silva on 10/12/23.
//

import Foundation
import SwiftUI

class BooksData: ObservableObject {
    let manager: DataServiceProtocol
    
    @Published var books: [Book]
    @Published var authorList: [Author]
    @Published var genres: [String]
    @AppStorage("Filter") var filter: Filter = .all
    @Published var text = ""
    
    @MainActor
    func loadBooks() async {
        var authorsList = [Author]()
        var genresList = [String]()
        
        self.books = await manager.getBooks()
        
        self.books.forEach { book in
            if !authorsList.contains(book.author) {
                authorsList.append(book.author)
            }
            
            if !genresList.contains(book.genre) {
                genresList.append(book.genre)
            }
        }
        
        self.authorList = authorsList
        self.genres = genresList
    }
    
    @MainActor
    var showingPicker: Bool {
        switch filter {
        case .all, .ascendingOrder:
            return false
        case .genre:
            if !genres.isEmpty {
                return true
            } else {
                return false
            }
        case .ratingEqual:
            return true
        case .authors:
            if !authorList.isEmpty {
                return true
            } else {
                return false
            }
        }
    }
    
    @MainActor
    var choiceText: [String] {
        switch filter {
        case .all:
            return []
        case .ascendingOrder:
            return []
        case .genre:
            return genres
        case .ratingEqual:
            return ["1", "2", "3", "4", "5"]
        case .authors:
            return authorList.map { $0.name }
        }
    }
    
    @MainActor
    var search: [Book] {
        switch filter {
        case .all:
            return books
        case .ascendingOrder:
            return books.sorted { $0 < $1 }
        case .genre:
            return books.filter { $0.genre.contains(text) }
        case .ratingEqual:
            return books.filter { String($0.rating).contains(text) }
        case .authors:
            return books.filter { $0.author.name.contains(text) }
        }
    }
    
    func createNewBook(title: String, authorName: String, releaseDate: Date, genre: String, review: String, rating: Int) async {
        await manager.addNewBook(title: title, authorName: authorName, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        await loadBooks()
    }
    
    func deleteBook(_ book: Book) async {
        await manager.deleteBook(book)
        await loadBooks()
    }
    
    init(manager: DataServiceProtocol) {
        self.manager = manager
        self.books = []
        self.authorList = []
        self.genres = []
    }
}
