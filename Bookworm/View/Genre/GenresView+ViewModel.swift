//
//  GenresView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import CoreData
import ErrorWrapper
import Foundation
import Observation
import os.log

extension GenresView {
    @Observable
    @MainActor
    final class ViewModel: NSObject {
        @ObservationIgnored
        private let storage: Storage
        
        @ObservationIgnored
        private let fetchedResultController: NSFetchedResultsController<Genre>
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "GenresView+ViewModel"
        )
        
        var genres = [Genre]()
        var showingAddNewGenre = false
        var showingEditGenre = false
        var error: ExecutionError?
        
        private func fetchGenres() {
            do {
                try storage.fetch(withController: fetchedResultController)
                
                let genres = fetchedResultController.fetchedObjects ?? []
                self.genres = genres
                
                logger.info("The fetch action was finished with success. Total found: \(genres.count)")
            } catch {
                self.error = error
            }
        }
        
        func deleteGenre(_ genre: Genre) {
            do {
                try storage.makeChanges { context in
                    context.delete(genre)
                }
                
                logger.info("The \(genre.wrappedName)'s genre was deleted with success.")
            } catch {
                self.error = error
            }
        }
        
        func showAddNewGenre() {
            self.showingAddNewGenre = true
            
            logger.info("The showingAddNewGenre was setted as true with success.")
        }
        
        func showEditGenre() {
            self.showingEditGenre = true
            
            logger.info("The showingEditGenre was setted as true with success.")
        }
        
        init(storage: Storage = .shared) {
            self.storage = storage
            
            let request = Genre.fetchRequest()
            request.sortDescriptors = []
            
            fetchedResultController = storage.fetchedResultController(for: request)
            
            super.init()
            
            fetchedResultController.delegate = self
            
            fetchGenres()
        }
    }
}

extension GenresView.ViewModel: @preconcurrency NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        genres = storage.fetchChanges(controller, by: Genre.self)
        
        logger.info("The genres list was updated with success.")
    }
}
