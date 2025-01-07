//
//  AuthorsView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import CoreData
import ErrorWrapper
import Foundation
import Observation
import os.log

extension AuthorsView {
    @Observable
    @MainActor
    final class ViewModel: NSObject {
        @ObservationIgnored
        private let storage: Storage
        
        @ObservationIgnored
        private let fetchedResultController: NSFetchedResultsController<Author>
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "AuthorsView+ViewModel"
        )
        
        var authors = [Author]()
        var showingAddNewAuthor = false
        var showingEditAuthor = false
        var error: ExecutionError?
        
        private func fetchAuthors() {
            do {
                try storage.fetch(withController: fetchedResultController)
                
                let authors = fetchedResultController.fetchedObjects ?? []
                self.authors = authors
                
                logger.info("The fetch action was finished with success. Total found: \(authors.count)")
            } catch {
                self.error = error
            }
        }
        
        func deleteAuthor(_ author: Author) {
            do {
                try storage.makeChanges { context in
                    context.delete(author)
                }
                
                logger.info("The author \(author.wrappedName) was deleted with success.")
            } catch {
                self.error = error
            }
        }
        
        func showAddNewAuthor() {
            self.showingAddNewAuthor = true
            
            logger.info("The showingAddNewAuthor was setted as true with success.")
        }
        
        func showEditAuthor() {
            self.showingEditAuthor = true
            
            logger.info("The showingEditAuthor was setted as true with success.")
        }
        
        init(storage: Storage = .shared) {
            self.storage = storage
            
            let request = Author.fetchRequest()
            request.sortDescriptors = []
            
            fetchedResultController = storage.fetchedResultController(for: request)
            
            super.init()
            
            fetchedResultController.delegate = self
            
            fetchAuthors()
        }
    }
}

extension AuthorsView.ViewModel: @preconcurrency NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        authors = storage.fetchChanges(controller, by: Author.self)
        
        logger.info("The author list was updated with success.")
    }
}
