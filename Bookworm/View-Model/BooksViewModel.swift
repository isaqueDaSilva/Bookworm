//
//  BooksViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import CoreData
import Foundation
import SwiftUI

extension BooksView {
    class BooksViewModel: ObservableObject {
        let manager = CoreDataMananger.shared
        
        @Published var showingAddNewBook = false
        @Published var ascendingChoice = true
        @AppStorage("Filter") var filter: Filter = .all
        @Published var text = ""
        
        let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
        let rating = ["1", "2", "3", "4", "5"]
        
        var search: [Books] {
            let books = manager.books
            
            if filter == .all {
                return books
            }
            
            if filter == .ascendingOrder {
                return books.sorted { $0.wrappedTitle < $1.wrappedTitle }
            }
            
//            if filter == .author {
//                return books.filter { ($0.author?.wrappedName.contains(text) != nil) }
//            }
            
            if filter == .genre {
                return books.filter { $0.wrappedGenre.contains(text) }
            }
            
            if filter == .ratingEqual {
                return books.filter { String($0.rating).contains(text) }
            }
            
            return books
        }
        
        
        func deleteBook(at indexSet: IndexSet) {
            guard let index = indexSet.first else { return }
            
            let book = manager.books[index]
            manager.context.delete(book)
            manager.save()
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
        
        init() {
            manager.fetchBooks()
        }
    }
}

enum Filter: String, CaseIterable {
    case all = "All"
    case ascendingOrder = "Ascending Order"
//    case author = "Author"
    case genre = "Genre"
    case ratingEqual = "Rating Equal to"
}
