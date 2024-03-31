//
//  HomeViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import Combine
import CoreData
import Foundation

extension HomeView {
    
    @MainActor
    final class HomeViewModel: NSObject, ObservableObject {
        // MARK: - Properties
        let storage: Storage
        private let fetchedResultController: NSFetchedResultsController<Book>
        
        @Published var books = [Book]()
        @Published var searchText = ""
        
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        
        @Published var showingAddNewBook = false
        
        var booksFiltered: [Book] {
            guard !searchText.isEmpty else { return books }
            
            return books.filter { $0.wrappedTitle.localizedCaseInsensitiveContains(searchText) }
        }
        
        // MARK: - Methods
        
        private func fetchBooks() {
            do {
                let fetchBooks = try storage.fetch(fetchedResultController)
                
                self.books = fetchBooks.sorted { $0.wrappedCreation > $1.wrappedCreation }
                
            } catch let error {
                self.alertTitle = "Falied to Fetch Books"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        func deleteBook(_ book: Book) {
            do {
                try self.storage.delete(book)
            } catch let error {
                self.alertTitle = "Falied to Delete Book"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
            
            let request = Book.fetchRequest()
            request.sortDescriptors = []
            
            fetchedResultController = storage.fetchedResultController(request)
            
            super.init()
            
            fetchedResultController.delegate = self
            
            fetchBooks()
        }
    }
}

extension HomeView.HomeViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        books = storage.fetchChanges(controller, by: Book.self)
    }
}
