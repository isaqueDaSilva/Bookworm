//
//  BookFormViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 28/02/24.
//

import Foundation

// Create new Book view Model
extension BookFormView {
    final class BookFormViewModel: ObservableObject {
        let storage: Storage
        
        let book: Book
        
        @Published var pickerItemSelect: PhotosPickerItem? = nil {
            didSet {
                if let pickerItemSelect {
                    getImage(pickerItemSelect)
                }
            }
        }
        
        @Published var title = ""
        @Published var author: Author?
        @Published var coverImage: UIImage?
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
        
        @Published var isEditMode = false
        
        var navTitle: String {
            let prefix = self.isEditMode ? "Edit" : "Add new"
            
            return "\(prefix) Author"
        }
        
        func save() {
            self.book.title = self.title
            self.book.author = self.author
            self.book.releaseDate = self.releaseDate
            self.book.genre = self.genre.rawValue
            self.book.startOfReading = self.startOfReading
            self.book.isFinished = self.isFinished
            self.book.review = self.review
            self.book.rating = Int16(self.rating)
            self.book.endOfReading = self.endOfReading
            
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
                self.book = bookSelected
                _title = Published(initialValue: bookSelected.wrappedTitle)
                _author = Published(initialValue: bookSelected.author)
                _releaseDate = Published(initialValue: bookSelected.wrappedReleaseDare)
                _genre = Published(initialValue: Genre(rawValue: bookSelected.wrappedGenre) ?? .fantasy)
                _review = Published(initialValue: bookSelected.wrappedReview)
                _rating = Published(initialValue: Int(bookSelected.rating))
                _startOfReading = Published(initialValue: bookSelected.wrappedStartOfReading)
                _endOfReading = Published(initialValue: bookSelected.wrappedEndOfReading)
                _isFinished = Published(initialValue: bookSelected.isFinished)
                
                self.isEditMode = true
            } else {
                self.book = Book(context: storage.context)
            }
        }
    }
}
