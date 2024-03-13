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
    /// Brings together all BookFormView execution logic and business logic.
    final class BookFormViewModel: ObservableObject {
        // MARK: - Properties
        let storage: Storage
        
        var bookSelected: Book? = nil
        
        
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
            let prefix = (self.bookSelected == nil) ? "Add New" : "Edit"
            
            return "\(prefix) Book"
        }
        
        // MARK: - Methods
        
        /// Creates a New book in Core Data.
        private func createBook() {
            let newBook = Book(context: storage.context)
            newBook.id = UUID()
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
        
        /// Updates an existing Book in Core Data.
        private func updateBook() {
            guard let bookSelected else { return }
            
            bookSelected.title = self.title
            bookSelected.author = self.author
            bookSelected.releaseDate = self.releaseDate
            bookSelected.genre = self.genre.rawValue
            bookSelected.startOfReading = self.startOfReading
            bookSelected.isFinished = self.isFinished
            bookSelected.review = self.review
            bookSelected.rating = Int16(self.rating)
            bookSelected.endOfReading = self.endOfReading
            
            if let coverImage {
                let imageData = coverImage.jpegData(compressionQuality: 0.6)
                bookSelected.cover = imageData
            }
        }
        
        /// Saves the changes will be occur in the Model.
        func save() {
            if self.bookSelected == nil {
                createBook()
            } else {
                updateBook()
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
        
        /// Initializes the View Model to execute the actions proposed in the View.
        /// - Parameters:
        ///   - storage: The type that contains the default container and viewContext types, of Core Data.
        ///   - book: An existing book that will be updated
        ///   - Warning: A book should only be passed in the parameter if it already exists in Core Data,
        ///    in order to update it. Otherwise, this parameter must remain set to nil.
        init(storage: Storage, book: Book? = nil) {
            self.storage = storage
            
            if let book {
                self.bookSelected = book
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
}
