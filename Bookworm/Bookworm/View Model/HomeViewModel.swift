//
//  HomeViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import CoreData
import Foundation

extension HomeView {
    /// Brings together all HomeView execution logic and business logic.
    final class HomeViewModel: ObservableObject {
        // MARK: - Properties
        let storage: Storage
        
        @Published var books = [Book]()
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        @Published var showingAddNewBook = false
        
        // MARK: - Methods
        
        /// Performs a search for books saved in Core Data.
        func fetchBooks() {
            do {
                let request = Book.fetchRequest()
                self.books = try storage.fetch(request)
                
            } catch let error {
                self.alertTitle = "Falied to Fetch Books"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        /// Performs a deletion action for book selected.
        /// - Parameter book: A Book selected for perform delete action.
        func deleteBook(_ book: Book) {
            do {
                try self.storage.delete(book)
                self.fetchBooks()
            } catch let error {
                self.alertTitle = "Falied to Delete Book"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        /// Initializes the View Model to execute the actions proposed in the View.
        /// - Parameter storage: The type that contains the default container and viewContext types, of Core Data.
        init(storage: Storage) {
            self.storage = storage
        }
    }
}
