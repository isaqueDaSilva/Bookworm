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
        
        /// Observe if there is any image selected and display it in the View.
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
        
        /// Checks if there is a book selected and displays an appropriate title for each case.
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
        
        /// Creates a new Book instance.
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
        
        /// Edit an exiting Book instance.
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
        
        /// Saves the changes will be occur in the Model.
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
        
        /// Gets and displays an image selected from the user's gallery.
        /// - Parameter pickerItemSelected: Represents an image item that has been selected.
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
        
        /// nitializes the View Model to create a new Book.
        /// - Parameter storage: The type that contains the default container and viewContext types, of Core Data.
        init(storage: Storage) {
            self.storage = storage
        }
        
        /// Initializes the View Model to update an existing Book.
        /// - Parameters:
        ///   - storage: The type that contains the default container and viewContext types, of Core Data.
        ///   - book: An existing book that will be updated
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
