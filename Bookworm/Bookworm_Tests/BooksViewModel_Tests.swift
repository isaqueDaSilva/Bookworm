//
//  BooksViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class BooksViewModel_Tests: XCTestCase {
    
    var manager: BooksMananger?
    var viewModel: BooksViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.manager = BooksMananger(stack: CoreDataTestStack())
        guard let manager = self.manager else { return }
        self.viewModel = BooksViewModel(manager: manager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manager = nil
        viewModel = nil
    }
    
    func test_BooksViewModel_books_houldBeInitializedEmptyOnFirstLaunchOfTheApp() {
        // Given
        guard let viewModel = self.viewModel else { return }
        // When
        
        // Then
        XCTAssertTrue(viewModel.books.isEmpty)
        XCTAssertEqual(viewModel.books.count, 0)
    }
    
    func test_BooksViewModel_books_shouldBeReloadSavedBooksWhenTheAppIsRestarted() {
        Task {
            // Given
            guard let manager = self.manager else { return }
            let title = UUID().uuidString
            let author = UUID().uuidString
            let releaseDate = Date.now
            let genre = UUID().uuidString
            let review = UUID().uuidString
            let rating = Int.random(in: 1...5)
            await manager.addNewBook(title: title, author: author, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
            
            // When
            guard let viewModel = self.viewModel else { return }
            viewModel.getBooks()
            
            // Then
            XCTAssertFalse(viewModel.books.isEmpty)
            XCTAssertGreaterThan(viewModel.books.count, 0)
        }
    }
    
    func test_BooksViewModel_authorList_shouldBeAnAuthorAfterANewBookCreated() {
        Task {
            // Given
            guard let manager = self.manager else { return }
            let title = UUID().uuidString
            let author = UUID().uuidString
            let releaseDate = Date.now
            let genre = UUID().uuidString
            let review = UUID().uuidString
            let rating = Int.random(in: 1...5)
            await manager.addNewBook(title: title, author: author, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
            
            // When
            guard let viewModel = self.viewModel else { return }
            viewModel.getBooks()
            let book = viewModel.books[0]
            
            // Then
            XCTAssertFalse(viewModel.authorList.isEmpty)
            XCTAssertGreaterThan(viewModel.authorList.count, 0)
            XCTAssertEqual(book.author?.wrappedName, author)
        }
    }
    
    func test_BooksViewModel_genre_shouldBeAnGenreAfterANewBookCreated() {
        Task {
            // Given
            guard let manager = self.manager else { return }
            let title = UUID().uuidString
            let author = UUID().uuidString
            let releaseDate = Date.now
            let genre = UUID().uuidString
            let review = UUID().uuidString
            let rating = Int.random(in: 1...5)
            await manager.addNewBook(title: title, author: author, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
            
            // When
            guard let viewModel = self.viewModel else { return }
            viewModel.getBooks()
            let book = viewModel.books[0]
            
            // Then
            XCTAssertFalse(viewModel.genres.isEmpty)
            XCTAssertGreaterThan(viewModel.genres.count, 0)
            XCTAssertEqual(book.genre, genre)
        }
    }
    
    func test_BooksViewModel_showingAddNewBook_shouldBeAutourizeDisplayedAddNewBookView() {
        // Given
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.displayAddNewBook()
        
        // Then
        XCTAssertTrue(viewModel.showingAddNewBook)
        XCTAssertEqual(viewModel.showingAddNewBook, true)
    }
}
