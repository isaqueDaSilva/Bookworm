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
        
        private func save() throws {
            try self.storage.save()
            fetchAuthors()
        }
        
        func fetchAuthors() {
            do {
                let request = Author.fetchRequest()
                self.authorList = try storage.context.fetch(request)
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
                storage.context.delete(author)
                
                try self.save()
            } catch let error {
                self.errorTitle = "Falied to Update the Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
        }
    }
}
