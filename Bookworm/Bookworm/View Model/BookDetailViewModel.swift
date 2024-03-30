//
//  BookDetailViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 05/03/24.
//

import CoreData
import Foundation
import UIKit

extension BookDetailView {
    final class BookDetailViewModel: ObservableObject {
        // MARK: - Properties
        
        let storage: Storage
        
        @Published var book: Book
        @Published var showingEditView = false
        @Published var showingAnnotationView = false
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        @Published var showingAlert = false
        @Published var isDeletingAlert = false
        
        var title: String {
            book.wrappedTitle
        }
        
        var author: String {
            book.wrappedAuthorName
        }
        
        var coverImage: UIImage? {
            book.coverImage
        }
        
        var releaseDate: String {
            book.wrappedReleaseDare.dateString()
        }
        
        var genre: String {
            book.wrappedGenre
        }
        
        var review: String {
            book.wrappedReview
        }
        
        var rating: Int {
            Int(book.rating)
        }
        
        var startOfReading: String {
            book.wrappedStartOfReading.dateString()
        }
        
        var endOfReading: String {
            book.wrappedEndOfReading.dateString()
        }
        
        var isFinished: Bool {
            book.isFinished
        }
        
        var annotationsCount: Int {
            book.wrappedAnnotations.count
        }
        
        // MARK: Methods
        
        func displayDeleteAlert() {
            self.isDeletingAlert = true
            self.alertTitle = "Delete Book"
            self.alertMessage = "Are you sure you want to delete this book?"
            self.showingAlert = true
        }
        
        func deleteBook() {
            do {
                try self.storage.delete(self.book)
            } catch let error {
                self.alertTitle = "Falied to Delete Books"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
        }
        
        init(storage: Storage, book: Book) {
            _book = Published(initialValue: book)
            self.storage = storage
        }
    }
}
