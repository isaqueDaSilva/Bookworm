//
//  BookDetailsViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

extension BookDetailsView {
    class BookDetailsViewModel: ObservableObject {
        let manager: BooksMananger
        
        @Published var deleteCurrentBookAlert = false
        
        private let book: Books
        private var onChange: () -> Void
        
        var bookTitle: String {
            book.wrappedTitle
        }
        
        var bookGenre: String {
            book.wrappedGenre
        }
        
        var bookAuthor: String {
            book.author?.wrappedName ?? "Unknown Author"
        }
        
        var bookReleaseDate: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: book.wrappedReleaseDate)
        }
        
        var bookReview: String {
            book.wrappedReview
        }
        
        var bookRating: Int {
            Int(book.rating)
        }
        
        func delete() {
            Task { @MainActor in 
                await manager.delete(book)
                onChange()
            }
        }
        
        init(manager: BooksMananger, book: Books, onChange: @escaping () -> Void) {
            self.manager = manager
            self.book = book
            self.onChange = onChange
        }
    }
}
