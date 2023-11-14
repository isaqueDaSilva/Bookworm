//
//  BooksViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation
import SwiftUI

extension BooksView {
    class BooksViewModel: ObservableObject {
        let manager: BooksMananger
        
        @Published var books = [Books]()
        @Published var authorList = [String]()
        @Published var genres = [String]()
        @Published var showingAddNewBook = false
        @AppStorage("Filter") var filter: Filter = .all
        @Published var text = ""
        
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
        
        var choiceText: [String] {
            switch filter {
            case .all:
                return []
            case .ascendingOrder:
                return []
            case .genre:
                return self.genres
            case .ratingEqual:
                return ["1", "2", "3", "4", "5"]
            case .authors:
                return self.authorList
            }
        }
        
        var search: [Books] {
            switch filter {
            case .all:
                return books
            case .ascendingOrder:
                return books.sorted { $0.wrappedTitle < $1.wrappedTitle }
            case .genre:
                return books.filter { $0.wrappedGenre.contains(text) }
            case .ratingEqual:
                return books.filter { String($0.rating).contains(text) }
            case .authors:
                return books.filter { $0.author!.wrappedName.contains(text) }
            }
        }
        
        func displayAddNewBook() {
            showingAddNewBook = true
        }
        
        func getBooks() {
            Task { @MainActor in
                await manager.fetchBooks()
                self.books = await manager.books
                getAuthorList()
                getGenreList()
            }
        }
        
        private func getAuthorList() {
            var authors = [String]()
            books.forEach { book in
                if !authors.contains(book.author!.wrappedName) {
                    authors.append(book.author!.wrappedName)
                }
            }
            self.authorList = authors
        }
        
        private func getGenreList() {
            var genresList = [String]()
            books.forEach { book in
                if !genresList.contains(book.wrappedGenre) {
                    genresList.append(book.wrappedGenre)
                }
            }
            self.genres = genresList
        }
        
        func delete(at indexSet: IndexSet) {
            Task { @MainActor in
                guard let index = indexSet.first else { return }
                let book = books[index]
                await manager.delete(book)
                self.getBooks()
            }
        }
        
        func textColor(_ rating: Int16) -> Color {
            var color: Color = .green
            if rating <= 2 {
                color = .red
            } else if rating > 2 && rating < 5 {
                color = .orange
            } else if rating == 5 {
                color = .green
            }
            return color
        }
        
        init(manager: BooksMananger) {
            self.manager = manager
            getBooks()
        }
    }
}
