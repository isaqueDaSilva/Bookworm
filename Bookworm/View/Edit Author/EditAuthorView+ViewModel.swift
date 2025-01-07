//
//  EditAuthorView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension EditAuthorView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let storage = Storage.shared
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "NewAuthorView+ViewModel"
        )
        
        @ObservationIgnored
        private let currentAuthorName: String
        
        var authorName = ""
        var error: ExecutionError?
        
        var isValidCreationValid: Bool {
            !authorName.isEmpty && authorName != currentAuthorName
        }
        
        func updateAuthor(_ author: Author) {
            do {
                try storage.makeChanges { [weak self] context in
                    guard let self else { return }
                    
                    guard self.isValidCreationValid else { return }
                    
                    author.name = self.authorName
                    
                    logger.info("The author's name was changed to \(author.wrappedName) with success.")
                }
            } catch {
                self.error = error
            }
        }
        
        init(authorName: String) {
            self.authorName = authorName
            
            self.currentAuthorName = authorName
        }
    }
}
