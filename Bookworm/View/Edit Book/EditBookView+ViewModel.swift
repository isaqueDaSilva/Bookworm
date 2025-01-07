//
//  EditBookView+ViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/6/25.
//

import ErrorWrapper
import Foundation
import Observation
import os.log

extension EditBookView {
    @Observable
    @MainActor
    final class ViewModel {
        @ObservationIgnored
        private let storage: Storage = .shared
        
        @ObservationIgnored
        private let logger = Logger(
            subsystem: "com.isaqueDaSilva.Bookworm",
            category: "EditBookView+ViewModel"
        )
        
        let book: Book
        
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
        
        func editBook(coverImageData: Data?) {
            guard let author, let genre else { return }
            
            do {
                try storage.makeChanges { [weak self] context in
                    guard let self else { return }
                    book.title = self.title
                    book.author = author
                    book.releaseDate = self.releaseDate
                    book.genre = genre
                    book.startOfReading = self.startOfReading
                    book.isFinished = self.isFinished
                    book.review = self.review
                    book.rating = Int16(self.rating)
                    book.endOfReading = self.endOfReading
                    book.cover = coverImageData
                }
            } catch {
                self.error = error
            }
        }
        
        init(book: Book) {
            self.book = book
            self.title = book.wrappedTitle
            self.author = book.author
            self.releaseDate = book.wrappedReleaseDate
            self.genre = book.genre
            self.review = book.wrappedReview
            self.rating = Int(book.rating)
            self.startOfReading = book.wrappedStartOfReading
            self.endOfReading = book.wrappedEndOfReading
            self.isFinished = book.isFinished
        }
    }
}
