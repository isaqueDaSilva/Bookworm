//
//  AnnotationFormViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 06/03/24.
//

import Foundation

extension AnnotationFormView {
    final class AnnotationFormViewModel: ObservableObject {
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
        
        private func save() throws {
            try self.storage.save()
        }
        
        func saveChanges(_ completationHandler: @escaping () -> Void) {
            self.annotation.id = UUID()
            self.annotation.title = self.title
            self.annotation.commentDescription = self.commentDescription
            self.annotation.creation = Date.now
            self.annotation.lastModification = Date.now
            self.annotation.book = self.book
            
            do {
                try self.save()
                completationHandler()
            } catch let error {
                self.alertTitle = "Falied to \(self.isEditMode ? "Edit" : "Create new") Annotation"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        func deleteAnnotation(_ completationHandler: @escaping () -> Void) {
            do {
                self.storage.context.delete(self.annotation)
                try self.save()
                completationHandler()
            } catch let error {
                self.alertTitle = "Falied to Delete Annotation"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
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
