//
//  BookDetailsViewModel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import Foundation

class BookDetailsViewModel: ObservableObject {
    @Published var deleteCurrentBookAlert = false
    @Published var showingSafafiView = false
    @Published var selectedText: String = "" 
    
    let book: Book
    
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
    
    func displaySafariSearchFor(_ term: String) {
        self.selectedText = term
        self.showingSafafiView = true
    }
    
    init(book: Book) {
        self.book = book
    }
}
