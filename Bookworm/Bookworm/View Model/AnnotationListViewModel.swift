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
        let storage: Storage
        let book: Book
        
        @Published var showingAddAnotationView = false
        
        @Published var annotations = [Annotation]()
        @Published var annotationSelected: Annotation? = nil
        
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        
        func showingFormView(_ annotation: Annotation? = nil) {
            self.annotationSelected = annotation
            self.showingAddAnotationView = true
        }
        
        private func save() throws {
            try self.storage.save()
            self.fetchAnnotations()
        }
        
        func fetchAnnotations() {
            do {
                let request = Annotation.fetchRequest()
                self.annotations = try storage.context.fetch(request)
            } catch let error {
                self.alertTitle = "Falied to Fetch Annotations"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        func deleteAnnotation(_ annotation: Annotation) {
            do {
                self.storage.context.delete(annotation)
                try self.save()
                
            } catch let error {
                self.alertTitle = "Falied to delete the annotation."
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        init(storage: Storage, book: Book) {
            self.storage = storage
            self.book = book
            
            self.fetchAnnotations()
        }
    }
}
