//
//  NewBookView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/6/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension NewBookView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let storage: Storage = .shared
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "NewBookView+ViewModel"
        )
        
        var title = ""
        var author: Author? = nil
        var releaseDate = Date.now
        var genre: Genre? = nil
        var review = ""
        var rating = 1
        var startOfReading = Date.now
        var endOfReading = Date.now
        var isFinished = false
        
        var error: ExecutionError?
        
        var isDisabled: Bool {
            (title.isEmpty) || (author == nil) || (genre == nil)
        }
        
        func createBook(coverImageData: Data?) {
            guard let author, let genre else { return }
            
            do {
                try storage.makeChanges { [weak self] context in
                    guard let self else { return }
                    
                    let newBook = Book(
                        context: context,
                        title: self.title,
                        author: author,
                        genre: genre,
                        cover: coverImageData,
                        releaseDate: self.releaseDate,
                        startOfReading: self.startOfReading,
                        isFinished: self.isFinished,
                        endOfReading: self.isFinished ? self.endOfReading : nil,
                        rating: self.isFinished ? self.rating : nil,
                        review: self.isFinished ? self.review : nil
                    )
                    
                    context.insert(newBook)
                }
            } catch {
                self.error = error
            }
        }
    }
}
