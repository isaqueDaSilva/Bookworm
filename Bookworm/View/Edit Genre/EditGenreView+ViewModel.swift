//
//  EditGenreView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/5/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension EditGenreView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let storage = Storage.shared
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "EditGenreView+ViewModel"
        )
        
        @ObservationIgnored
        private let currentGenreName: String
        
        var genreName = ""
        var error: ExecutionError?
        
        var isValidCreationValid: Bool {
            !genreName.isEmpty && genreName != currentGenreName
        }
        
        func updateGenre(_ genre: Genre) {
            do {
                try storage.makeChanges { [weak self] context in
                    guard let self else { return }
                    
                    guard self.isValidCreationValid else { return }
                    
                    genre.name = self.genreName
                    
                    logger.info("The genre's name was changed to \(genre.wrappedName) with success.")
                }
            } catch {
                self.error = error
            }
        }
        
        init(genreName: String) {
            self.genreName = genreName
            self.currentGenreName = genreName
        }
    }
}
