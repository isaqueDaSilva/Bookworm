//
//  AnnotationListViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import CoreData
import Foundation

extension AnnotationListView {
    @MainActor
    final class AnnotationListViewModel: NSObject, ObservableObject {
        // MARK: - Properties
        
        let storage: Storage
        let book: Book
        
        private let fetchedResultController: NSFetchedResultsController<Annotation>
        
        @Published var showingAddAnotationView = false
        
        @Published var annotations = [Annotation]()
        @Published var annotationSelected: Annotation? = nil
        
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        
        // MARK: - Methods
        
        func showingFormView(_ annotation: Annotation? = nil) {
            self.annotationSelected = annotation
            self.showingAddAnotationView = true
        }
        
        private func save() throws {
            try self.storage.save()
        }
        
        private func fetchAnnotations() {
            do {
                let annotations = try storage.fetch(fetchedResultController)
                self.annotations = annotations
            } catch let error {
                self.alertTitle = "Falied to Fetch Annotations"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        func deleteAnnotation(_ annotation: Annotation) {
            do {
                try self.storage.delete(annotation)
                try save()
            } catch let error {
                self.alertTitle = "Falied to delete the annotation."
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        init(storage: Storage, book: Book) {
            self.storage = storage
            self.book = book
            
            let request = Annotation.fetchRequest()
            request.sortDescriptors = []
            request.predicate = NSPredicate(format: "book == %@", book)
            
            fetchedResultController = storage.fetchedResultController(request)
            
            super.init()
            
            fetchedResultController.delegate = self
            
            fetchAnnotations()
        }
    }
}

extension AnnotationListView.AnnotationListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        annotations = storage.fetchChanges(controller, by: Annotation.self)
    }
}
