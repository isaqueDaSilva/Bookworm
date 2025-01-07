//
//  NewGenreView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension NewGenreView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let storage = Storage.shared
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "NewGenreView+ViewModel"
        )
        
        var title = ""
        var error: ExecutionError?
        
        var isValidCreationValid: Bool {
            !title.isEmpty
        }
        
        func createNewGenre() {
            do {
                try storage.makeChanges { [weak self] context in
                    guard let self else { return }
                    
                    guard isValidCreationValid else { return }
                    
                    let newGenre = Genre(
                        context: context,
                        name: self.title
                    )
                    
                    context.insert(newGenre)
                    
                    logger.info("The \(newGenre.wrappedName)'s genre was created with success.")
                }
            } catch {
                self.error = error
            }
        }
    }
}
