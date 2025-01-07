//
//  BookDetailView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension BookDetailView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let storage: Storage = .shared
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "BookDetailView+ViewModel"
        )
        
        var showingAlert = false
        var isDeletingAlert = false
        var showingEditBookView = false
        var error: ExecutionError?
        
        func showDeletionAlert() {
            isDeletingAlert = true
            showingAlert = true
        }
        
        func showEditBookView() {
            showingEditBookView = true
        }
        
        func deleteBook(_ book: Book) {
            do {
                try storage.makeChanges { context in
                    context.delete(book)
                }
                
                logger.info(
                    "The book instance with named as \(book.wrappedTitle), was deleted with sucess."
                )
            } catch {
                self.error = error
            }
        }
    }
}
