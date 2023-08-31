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
        @Published var filter: Filter = .author
        @Published var text = ""
        
        var filtering: String {
            var filterScript = ""
            
            if filter == .author {
                filterScript = "author == %@"
            }
            
            if filter == .genre {
                filterScript = "genre == %@"
            }
            
            if filter == .ratingEqual {
                filterScript = "rating == %@"
            }
            
            if filter == .ratingGreaterThan {
                filterScript = "rating > %@"
            }
            
            if filter == .ratingLessThan {
                filterScript = "rating < %@"
            }
            return filterScript
        }
        
        let ascendingOrder = [true, false]
        func fetchBooks() {
            let request = NSFetchRequest<Books>(entityName: "Books")
            let sort = NSSortDescriptor(keyPath: \Books.author, ascending: ascendingChoice)
            let filter = NSPredicate(format: filtering, text)
            
            request.sortDescriptors = [sort]
            request.predicate = filter
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
    case author = "Author"
    case genre = "Genre"
    case ratingEqual = "Rating Equal to"
    case ratingGreaterThan = "Rating Greater Than"
    case ratingLessThan = "Rating Less Than"
}
