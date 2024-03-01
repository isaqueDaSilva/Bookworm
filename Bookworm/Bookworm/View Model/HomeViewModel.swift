//
//  BooksViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import Foundation

extension HomeView {
    final class BooksViewModel: ObservableObject {
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        @Published var showingAddNewBook = false
        
        func deleteBook(
            _ book: Book,
            _ completion: @escaping (Book) throws -> Void
        ) {
            do {
                book.isDisabled = true
                try completion(book)
            } catch let error {
                self.errorTitle = "Falied to Delete Book"
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
    }
}
