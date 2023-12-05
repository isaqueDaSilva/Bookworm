//
//  BooksViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation
import SwiftUI

class BooksViewModel: ObservableObject {
    let manager: DataServiceProtocol
    
    @MainActor @Published var books = [Book]()
    @MainActor @Published var authorList = [Author]()
    @MainActor @Published var genres = [String]()
    @Published var showingAddNewBook = false
    @AppStorage("Filter") var filter: Filter = .all
    @Published var text = ""
    
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
            return self.genres
        case .ratingEqual:
            return ["1", "2", "3", "4", "5"]
        case .authors:
            return self.authorList.map { $0.name }
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
    
    func displayAddNewBook() {
        self.showingAddNewBook = true
    }
    
    func getBooks() async {
        let (bookList, authorsList, genresList) = await manager.getBooks()
        
        await MainActor.run {
            self.books = bookList
            self.authorList = authorsList
            self.genres = genresList
        }
    }
    
    func delete(_ book: Book) async {
        await manager.delete(book)
        await self.getBooks()
    }
    
    func textColor(_ rating: Int) -> Color {
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
    
    init(manager: DataServiceProtocol) {
        self.manager = manager
    }
}
