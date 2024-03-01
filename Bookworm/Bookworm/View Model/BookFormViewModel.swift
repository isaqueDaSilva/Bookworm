//
//  CreateBookViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 28/02/24.
//

import Foundation

extension FormView {
    final class CreateBookViewModel: ObservableObject {
        @Published var title = ""
        @Published var author: Author?
        @Published var releaseDate = Date.now
        @Published var genre: Genre = .fantasy
        @Published var review = ""
        @Published var rating = 1
        @Published var isLoadingState = false
        @Published var errorTile = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        
        var authorName: String {
            author?.authorName ?? "No Author"
        }
        
        private func createNewBook() throws -> Book {
            guard let author = self.author else {
                throw StorageError.dataNotFound
            }
            
            return Book(
                id: UUID(),
                title: self.title,
                author: author,
                releaseDate: self.releaseDate,
                genre: self.genre,
                review: self.review,
                rating: self.rating
            )
        }
        
        func addBook(_ completion: @escaping ((Book) throws -> Void)) {
            do {
                self.isLoadingState = true
                let newBook = try self.createNewBook()
                try completion(newBook)
            } catch let error {
                self.errorTile = "Falied to Create New Book"
                self.errorMessage = error.localizedDescription
                self.isLoadingState = false
                showingError = true
            }
        }
    }
}
