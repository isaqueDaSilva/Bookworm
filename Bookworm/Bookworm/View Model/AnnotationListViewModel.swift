//
//  AnnotationListViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import CoreData
import Foundation

extension AnnotationListView {
    final class AnnotationListViewModel: ObservableObject {
        // MARK: - Properties
        
        let storage: Storage
        let book: Book
        
        @Published var showingAddAnotationView = false
        
        @Published var annotations = [Annotation]()
        @Published var annotationSelected: Annotation? = nil
        
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        
        // MARK: - Methods
        
        /// Displays the AnotationFormView for create or update some annotation.
        /// - Parameter annotation: An instance of Annotation for make some update.
        /// - Warning: Only pass an Annotation as argument in this method,
        /// if you that's make some update, otherwise leave this argument with `nil` value.
        func showingFormView(_ annotation: Annotation? = nil) {
            self.annotationSelected = annotation
            self.showingAddAnotationView = true
        }
        
        /// Saves changes in Core Data, and after this,
        /// perform a search for this updates and returns the result for user.
        private func save() throws {
            try self.storage.save()
            self.fetchAnnotations()
        }
        
        ///Performs a search for instances of saved Annotations.
        func fetchAnnotations() {
            do {
                let request = Annotation.fetchRequest()
                request.predicate = NSPredicate(format: "book == %@", book)
                self.annotations = try storage.fetch(request)
            } catch let error {
                self.alertTitle = "Falied to Fetch Annotations"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        /// Deletes an Annotation selected.
        /// - Parameter annotation: An Annotation selected for perform a delete action.
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
        
        /// Initializes the View Model to execute the actions proposed in the View.
        /// - Parameters:
        ///   - storage: The type that contains the default container and viewContext types, of Core Data.
        ///   - book: A book instance that will be used to create, read, update and delete an Annotation instance
        init(storage: Storage, book: Book) {
            self.storage = storage
            self.book = book
        }
    }
}
