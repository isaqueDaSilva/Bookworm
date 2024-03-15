//
//  AnnotationFormViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 06/03/24.
//

import Foundation

extension AnnotationFormView {
    final class AnnotationFormViewModel: ObservableObject {
        // MARK: - Properties
        let storage: Storage
        let annotation: Annotation
        let book: Book
        
        @Published var isEditMode = false
        
        @Published var title = ""
        @Published var commentDescription = ""
        
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        
        var lastUpdate: String {
            annotation.wrappedLastModification.dateString()
        }
        
        // MARK: Methods
        
        /// Saves changes in Core Data.
        private func save() throws {
            try self.storage.save()
        }
        
        
        /// Saves the change that will be occur.
        func saveChanges() {
            self.annotation.id = UUID()
            self.annotation.title = self.title
            self.annotation.commentDescription = self.commentDescription
            self.annotation.creation = Date.now
            self.annotation.lastModification = Date.now
            self.annotation.book = self.book
            
            do {
                try self.save()
            } catch let error {
                self.alertTitle = "Falied to \(self.isEditMode ? "Edit" : "Create new") Annotation"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        /// Deletes an Annotation from Core Data.
        func deleteAnnotation() {
            do {
                self.storage.context.delete(self.annotation)
                try self.save()
            } catch let error {
                self.alertTitle = "Falied to Delete Annotation"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        /// Initializes the View Model to execute the actions proposed in the View.
        /// - Parameters:
        ///   - storage: The type that contains the default container and viewContext types, of Core Data.
        ///   - annotation: An instance of Annotation for make some update.
        ///   - book: A book instance that will be used to create, read, update and delete an Annotation instance
        /// - Warning: Only pass an Annotation as argument in this method,
        ///   if you that's make some update, otherwise leave this argument with `nil` value.
        init(
            storage: Storage,
            annotation: Annotation? = nil,
            book: Book
        ) {
            self.storage = storage
            self.book = book
            
            guard let annotation else {
                self.annotation = Annotation(context: storage.context)
                return
            }
            
            self.annotation = annotation
            _title = Published(initialValue: annotation.wrappedTitle)
            _commentDescription = Published(initialValue: annotation.wrappedCommentDescription)
            self.isEditMode = true
        }
    }
}
