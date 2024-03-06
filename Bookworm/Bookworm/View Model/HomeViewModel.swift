//
//  HomeViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import CoreData
import Foundation

extension HomeView {
    final class HomeViewModel: ObservableObject {
        var storage: Storage
        
        @Published var books = [Book]()
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        @Published var showingAddNewBook = false
        
        func fetchBooks() {
            do {
                let request = NSFetchRequest<Book>(entityName: EntityNames.book.rawValue)
                self.books = try storage.context.fetch(request)
            } catch let error {
                self.errorTitle = "Falied to Fetch Books"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        func deleteBook(_ book: Book) {
            do {
                book.isDisabled = true
                storage.context.delete(book)
                try storage.save()
                self.fetchBooks()
            } catch let error {
                self.errorTitle = "Falied to Delete Book"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
            
            self.fetchBooks()
        }
    }
}
