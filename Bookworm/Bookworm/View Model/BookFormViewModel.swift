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
        let storage: Storage
        
        var bookSelected: Book? = nil
        
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
            let prefix = (self.bookSelected == nil) ? "Add New" : "Edit"
            
            return "\(prefix) Author"
        }
        
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
        
        init(storage: Storage, book: Book? = nil) {
            self.storage = storage
            
            if let bookSelected = book {
                self.bookSelected = bookSelected
                _title = Published(initialValue: bookSelected.wrappedTitle)
                _author = Published(initialValue: bookSelected.author)
                _releaseDate = Published(initialValue: bookSelected.wrappedReleaseDare)
                _genre = Published(initialValue: Genre(rawValue: bookSelected.wrappedGenre) ?? .fantasy)
                _review = Published(initialValue: bookSelected.wrappedReview)
                _rating = Published(initialValue: Int(bookSelected.rating))
                _startOfReading = Published(initialValue: bookSelected.wrappedStartOfReading)
                _endOfReading = Published(initialValue: bookSelected.wrappedEndOfReading)
                _isFinished = Published(initialValue: bookSelected.isFinished)
                
                if let imageData = book?.cover {
                    let image = UIImage(data: imageData)
                    _coverImage = Published(initialValue: image)
                }
            }
        }
    }
}
