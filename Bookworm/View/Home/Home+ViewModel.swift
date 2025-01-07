//
//  ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import CoreData
import ErrorWrapper
import Foundation
import Observation
import os.log

extension HomeView {
    @Observable
    @MainActor
    final class ViewModel: NSObject {
        // MARK: - Properties
        @ObservationIgnored
        private let storage: Storage
        
        @ObservationIgnored
        private let fetchedResultController: NSFetchedResultsController<Book>
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "HomeView+ViewModel"
        )
        
        var books = [Book]()
        var searchText = ""
        
        var error: ExecutionError?
        
        var showingAddNewBook = false
        
        var booksFiltered: [Book] {
            guard !searchText.isEmpty else { return books }
            
            let booksFiltered = books.filter {
                $0.wrappedTitle.localizedCaseInsensitiveContains(searchText)
            }
            
            logger.info(
                "The filtering for instances matched as \(self.searchText) was finished. Total: \(booksFiltered.count)"
            )
            
            return booksFiltered
        }
        
        // MARK: - Methods
        
        func openAddNewBookView() {
            showingAddNewBook = true
        }
        
        private func fetchBooks() {
            do {
                try storage.fetch(withController: fetchedResultController)
                
                let books = fetchedResultController.fetchedObjects
                
                if let books {
                    self.books = books.sorted { $0.wrappedCreateAt > $1.wrappedCreateAt }
                } else {
                    self.books = []
                }
                
                logger.info("New book instances was fetched with success. Total: \(self.books.count)")
                
            } catch {
                self.error = error
            }
        }
        
        func deleteBook(_ book: Book) {
            do {
                try self.storage.makeChanges { context in
                    context.delete(book)
                }
                
                logger.info("The book with title, \(book.wrappedTitle), was deleted with success.")
            } catch {
                self.error = error
            }
        }
        
        init(storage: Storage = .shared) {
            self.storage = storage
            
            let request = Book.fetchRequest()
            request.sortDescriptors = []
            
            fetchedResultController = storage.fetchedResultController(for: request)
            
            super.init()
            
            fetchedResultController.delegate = self
            
            fetchBooks()
        }
    }
}

extension HomeView.ViewModel: @preconcurrency NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        books = storage.fetchChanges(controller, by: Book.self)
    }
}
