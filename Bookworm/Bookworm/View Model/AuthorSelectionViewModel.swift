//
//  AuthorSelectionViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 01/03/24.
//

import CoreData
import Foundation

extension AuthorSelectionView {
    
    @MainActor
    final class AuthorSelectionViewModel: NSObject, ObservableObject {
        // MARK: - Properties
        let storage: Storage
        private let fetchedResultController: NSFetchedResultsController<Author>
        
        private var authorSelected: Author?
        @Published var authorList = [Author]()
        
        @Published var showingEditor = false
        @Published var authorName = ""
        
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        
        var editorTitle: String {
            authorSelected != nil ? "New Author" : "Edit Author"
        }
        
        // MARK: - Methods
        private func save() throws {
            try self.storage.save()
        }
        
        private func fetchAuthors() {
            do {
                let authors = try storage.fetch(fetchedResultController)
                
                authorList = authors
            } catch let error {
                self.errorTitle = "Falied to Fetch Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        func showingEditor(_ author: Author? = nil) {
            self.authorSelected = author
            
            if let authorSelected {
                self.authorName = authorSelected.wrappedName
            }
            
            self.showingEditor = true
        }
        
        private func createAuthor() {
            let newAuthor = Author(context: storage.context)
            newAuthor.id = UUID()
            newAuthor.name = self.authorName
            
            do {
                try self.save()
            } catch let error {
                self.errorTitle = "Falied to Create a New Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        private func updateAuthor() {
            guard let authorSelected else { return }
            
            authorSelected.name = self.authorName
            
            do {
                try self.save()
            } catch let error {
                self.errorTitle = "Falied to Update the Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        func saveChanges() {
            if authorSelected == nil {
                self.createAuthor()
            } else {
                self.updateAuthor()
            }
        }
        
        func deleteAuthor(_ author: Author) {
            do {
                try self.storage.delete(author)
                self.fetchAuthors()
            } catch let error {
                self.errorTitle = "Falied to Update the Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
            
            let request = Author.fetchRequest()
            request.sortDescriptors = []
            
            fetchedResultController = storage.fetchedResultController(request)
            
            super.init()
            
            fetchedResultController.delegate = self
            
            fetchAuthors()
        }
    }
}

extension AuthorSelectionView.AuthorSelectionViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        authorList = storage.fetchChanges(controller, by: Author.self)
    }
}
