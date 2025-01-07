//
//  NewAuthorView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension NewAuthorView {
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
        
        var authorName = ""
        var error: ExecutionError?
        
        var isValidCreationValid: Bool {
            !authorName.isEmpty
        }
        
        func createNewAuthor() {
            do {
                try storage.makeChanges { [weak self] context in
                    guard let self else { return }
                    
                    guard isValidCreationValid else { return }
                    
                    let newAuthor = Author(
                        context: context,
                        name: self.authorName
                    )
                    
                    context.insert(newAuthor)
                    
                    logger.info("The author \(newAuthor.wrappedName) was created with success.")
                }
            } catch {
                self.error = error
            }
        }
    }
}
