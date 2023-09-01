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
        
        @Published var books = [Books]()
        @Published var showingAddNewBook = false
        @Published var ascendingChoice = true
        @Published var filter: Filter = .all
        @Published var text = ""
        
        let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
        let rating = ["1", "2", "3", "4", "5"]
        var search: [Books] {
            books.filter { book in
                var filtering = false
                if filter == .all {
                    filtering = !book.wrappedTitle.contains(text)
                }
                if filter == .author {
                    filtering = ((book.author?.wrappedName.contains(text)) != nil)
                }
                if filter == .genre {
                    filtering = book.wrappedGenre.contains(text)
                }
                if filter == .ratingEqual || filter == .ratingGreaterThan || filter == .ratingLessThan {
                    filtering = String(book.rating).contains(text)
                }
                return filtering
            }
        }
        
        func fetchBooks() {
            let request = NSFetchRequest<Books>(entityName: "Books")
            do {
                books = try manager.context.fetch(request)
            } catch let error {
                fatalError("Falied to fetching books in Data Model. Error \(error)")
            }
        }
        
        func deleteBook(at indexSet: IndexSet) {
            guard let index = indexSet.first else { return }
            
            let book = books[index]
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
    }
}

enum Filter: String, CaseIterable {
    case all = "All"
    case author = "Author"
    case genre = "Genre"
    case ratingEqual = "Rating Equal to"
    case ratingGreaterThan = "Rating Greater Than"
    case ratingLessThan = "Rating Less Than"
}
