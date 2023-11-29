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
    @Published var showingSafafiView = false
    @Published var selectedText: String = "" 
    
    private let book: Book
    private var onChange: () async -> Void
    
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
    
    func delete() async {
        await manager.delete(book)
        await onChange()
    }
    
    func displaySafariView() {
        self.showingSafafiView = true
    }
    
    init(manager: BooksMananger, book: Book, onChange: @escaping () async -> Void) {
        self.manager = manager
        self.book = book
        self.onChange = onChange
    }
}
