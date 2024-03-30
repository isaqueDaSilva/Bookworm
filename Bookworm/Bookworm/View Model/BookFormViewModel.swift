//
//  BookFormViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 28/02/24.
//

import Foundation
import SwiftUI
import PhotosUI

extension BookFormView {
    final class BookFormViewModel: ObservableObject {
        // MARK: - Properties
        let storage: Storage
        
        private var book: Book?
        
        @Published var pickerItemSelect: PhotosPickerItem? = nil {
            didSet {
                if let pickerItemSelect {
                    getImage(pickerItemSelect)
                }
            }
        }
        
        @Published var title = ""
        @Published var author: Author? = nil
        @Published var coverImage: UIImage? = nil
        @Published var releaseDate = Date.now
        @Published var genre: Genre = .fantasy
        @Published var review = ""
        @Published var rating = 1
        @Published var startOfReading = Date.now
        @Published var endOfReading = Date.now
        @Published var isFinished = false
        
        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        
        @Published var showingAuthorSelectionView = false
        
        var navTitle: String {
            if book != nil {
                return "Edit Book"
            } else {
                return "Create Book"
            }
        }
        
        var isDisabled: Bool {
            return (title.isEmpty) || (author == nil)
        }
        
        // MARK: - Methods
        
        private func createBook() {
            let newBook = Book(context: self.storage.context)
            newBook.id = UUID()
            newBook.creation = Date.now
            newBook.title = self.title
            newBook.author = self.author
            newBook.releaseDate = self.releaseDate
            newBook.genre = self.genre.rawValue
            newBook.startOfReading = self.startOfReading
            newBook.isFinished = self.isFinished
            newBook.review = self.review
            newBook.rating = Int16(self.rating)
            newBook.endOfReading = self.endOfReading
            
            if let coverImage {
                let imageData = coverImage.jpegData(compressionQuality: 0.6)
                newBook.cover = imageData
            }
        }
        
        private func editBook() {
            guard let book else { return }
            
            book.title = self.title
            book.author = self.author
            book.releaseDate = self.releaseDate
            book.genre = self.genre.rawValue
            book.startOfReading = self.startOfReading
            book.isFinished = self.isFinished
            book.review = self.review
            book.rating = Int16(self.rating)
            book.endOfReading = self.endOfReading
            
            if let coverImage {
                let imageData = coverImage.jpegData(compressionQuality: 0.6)
                book.cover = imageData
            }
        }
        
        func save() {
            if book != nil {
                self.editBook()
            } else {
                self.createBook()
            }
            
            do {
                try storage.save()
            } catch let error {
                self.errorTitle = "Falied to save changes."
                self.errorMessage = error.localizedDescription
                self.showingError = true
            }
        }
        
        func getImage(_ pickerItemSelected: PhotosPickerItem) {
            Task {
                if let pickerItemSelect,
                   let data = try? await pickerItemSelect.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        await MainActor.run {
                            self.coverImage = image
                        }
                    }
                }
            }
        }
        
        // MARK: - Initializers
        
        init(storage: Storage) {
            self.storage = storage
        }
        
        init(storage: Storage, book: Book) {
            self.storage = storage
            
            self.book = book
            _title = Published(initialValue: book.wrappedTitle)
            _author = Published(initialValue: book.author)
            _releaseDate = Published(initialValue: book.wrappedReleaseDare)
            _genre = Published(initialValue: Genre(rawValue: book.wrappedGenre) ?? .fantasy)
            _review = Published(initialValue: book.wrappedReview)
            _rating = Published(initialValue: Int(book.rating))
            _startOfReading = Published(initialValue: book.wrappedStartOfReading)
            _endOfReading = Published(initialValue: book.wrappedEndOfReading)
            _isFinished = Published(initialValue: book.isFinished)
            
            if let imageData = book.cover {
                let image = UIImage(data: imageData)
                _coverImage = Published(initialValue: image)
            }
        }
    }
}
