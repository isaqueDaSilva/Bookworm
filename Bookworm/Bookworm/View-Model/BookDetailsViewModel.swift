//
//  BookDetailsViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

class BookDetailsViewModel: ObservableObject {
    let manager: BooksMananger
    
    @Published var deleteCurrentBookAlert = false
    
    private let book: Book
    private var onChange: () -> Void
    
    var bookTitle: String {
        book.title
    }
    
    var bookGenre: String {
        book.genre
    }
    
    var bookAuthor: String {
        book.author.name
    }
    
    var bookReleaseDate: String {
        book.releaseDateFormatted
    }
    
    var bookReview: String {
        book.review
    }
    
    var bookRating: Int {
        book.rating
    }
    
    func displayAlert() {
        self.deleteCurrentBookAlert = true
    }
    
    func delete() {
        Task { @MainActor in
            await manager.delete(book)
            onChange()
        }
    }
    
    init(manager: BooksMananger, book: Book, onChange: @escaping () -> Void) {
        self.manager = manager
        self.book = book
        self.onChange = onChange
    }
}
