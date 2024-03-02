//
//  AuthorSelectionViewMode.swift
//  Bookworm
//
//  Created by Isaque da Silva on 01/03/24.
//

import Combine
import Foundation

extension AuthorSelection {
    final class AuthorSelectionViewMode: ObservableObject {
        @Published var storage: Storage
        
        @Published var authorsList = [Author]()
        @Published var authorName = ""
        
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        
        var cancellable = Set<AnyCancellable>()
        
        private func observerAuthors() {
            $storage
                .sink { [weak self] storage in
                    guard let self = self else { return }
                    self.authorsList = storage.authors
                }
                .store(in: &cancellable)
        }
        
        func createAuthor() {
            do {
                let newAuthor = Author(id: UUID(), authorName: self.authorName)
                try self.storage.createAuthor(newAuthor)
            } catch let error {
                self.errorTitle = "Failed to save changes"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
        }
    }
}
