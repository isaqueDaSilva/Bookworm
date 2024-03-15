//
//  AuthorSelectionViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 01/03/24.
//

import CoreData
import Foundation

extension AuthorSelectionView {
    final class AuthorSelectionViewModel: ObservableObject {
        // MARK: - Properties
        let storage: Storage
        
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
            self.fetchAuthors()
        }
        
        /// Performs a search for saved authors.
        func fetchAuthors() {
            do {
                let request = Author.fetchRequest()
                self.authorList = try storage.fetch(request)
            } catch let error {
                self.errorTitle = "Falied to Fetch Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        /// Displays the editor for create or update author.
        /// - Parameter author: An Author value to perform an update action.
        func showingEditor(_ author: Author? = nil) {
            self.authorSelected = author
            
            if let authorSelected {
                self.authorName = authorSelected.wrappedName
            }
            
            self.showingEditor = true
        }
        
        /// Creates a new Author.
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
        
        /// Updates a selected Author.
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
        
        /// Save the changes will be in some Author Model.
        func saveChanges() {
            if authorSelected == nil {
                self.createAuthor()
            } else {
                self.updateAuthor()
            }
        }
        
        /// Deletes an Author selected.
        /// - Parameter author: An Author that was selected for perform de deletion action.
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
        
        /// Initializes the View Model to execute the actions proposed in the View.
        /// - Parameter storage: The type that contains the default container and viewContext types, of Core Data.
        init(storage: Storage) {
            self.storage = storage
        }
    }
}
