//
//  AnnotationsView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import CoreData
import ErrorWrapper
import Foundation
import Observation
import os.log

extension AnnotationsView {
    @Observable
    @MainActor
    final class ViewModel: NSObject {
        // MARK: - Properties
        
        @ObservationIgnored
        private let storage: Storage
        
        @ObservationIgnored
        private let fetchedResultController: NSFetchedResultsController<Annotation>
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "AnnotationsListView+ViewModel"
        )
        
        var showingNewAnotationView = false
        var annotations: [Annotation]
        var error: ExecutionError?
        
        // MARK: - Methods
        private func performFetch() {
            do {
                try storage.fetch(withController: fetchedResultController)
                
                logger.info(
                    "The fetch Action was finished with success. Where found \(self.annotations.count) instances."
                )
            } catch {
                self.error = error
            }
        }
        
        func showNewAnnotationView() {
            self.showingNewAnotationView = true
            
            logger.info("The showingNewAnotationView was set as true with success.")
        }
        
        func deleteAnnotation(_ annotation: Annotation) {
            do {
                try storage.makeChanges { context in
                    context.delete(annotation)
                }
                
                logger.info("The \(annotation.wrappedTitle) was deleted with success.")
            } catch let error {
                self.error = error
            }
        }
        
        init(storage: Storage, bookTitle: String, annotations: [Annotation]) {
            self.storage = storage
            self.annotations = annotations
            
            let request = Annotation.fetchRequest()
            request.sortDescriptors = []
            request.predicate = NSPredicate(format: "book.title == %@", bookTitle)
            
            fetchedResultController = storage.fetchedResultController(for: request)
            
            super.init()
            
            fetchedResultController.delegate = self
            
            performFetch()
            
            logger.info("The AnnotationsListView+ViewModel was created with success.")
        }
        
        deinit {
            logger.info("AnnotationsView+ViewModel was deinitialized with success")
        }
    }
}

extension AnnotationsView.ViewModel: @preconcurrency NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        annotations = storage.fetchChanges(controller, by: Annotation.self)
    }
}
