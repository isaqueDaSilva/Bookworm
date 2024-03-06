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
        
        @Published var authorSelected: Author?
        @Published var authorList = [Author]()
        
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        
        
        private func save() throws {
            try self.storage.save()
            fetchAuthors()
        }
        
        func fetchAuthors() {
            do {
                let request = NSFetchRequest<Author>(entityName: EntityNames.author.rawValue)
                self.authorList = try storage.context.fetch(request)
            } catch let error {
                self.errorTitle = "Falied to Fetch Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        func createAuthor(_ authorName: String) {
            let newAuthor = Author(context: storage.context)
            newAuthor.id = UUID()
            newAuthor.name = authorName
            
            do {
                try self.save()
            } catch let error {
                self.errorTitle = "Falied to Create a New Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        func updateAuthor(_ author: Author, _ authorName: String) {
            author.name = authorName
            
            do {
                try self.save()
            } catch let error {
                self.errorTitle = "Falied to Update the Authors"
                self.errorMessage = error.localizedDescription
                self.showingError = true
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
        
        init(storage: Storage, author: Author?) {
            self.storage = storage
            _authorSelected = Published(initialValue: author)
            
            self.fetchAuthors()
        }
    }
}
