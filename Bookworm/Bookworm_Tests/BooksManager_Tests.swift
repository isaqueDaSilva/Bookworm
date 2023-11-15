//
//  BooksManager_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class BooksManager_Tests: XCTestCase {

    var manager: BooksMananger?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.manager = BooksMananger(stack: CoreDataTestStack())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.manager = nil
    }

    func test_BooksManager_books_shouldBeInitializedEmptyOnFirstLaunchOfTheApp() async {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        await manager.fetchBooks()
        let books = await manager.books
        // Then
        XCTAssertTrue(books.isEmpty)
        XCTAssertEqual(books.count, 0)
    }
    
    func test_BooksManager_books_shouldBeContain1BooksAfterSaving() async {
        // Given
        let title = UUID().uuidString
        let author = UUID().uuidString
        let releaseDate = Date.now
        let genre = UUID().uuidString
        let review = UUID().uuidString
        let rating = Int.random(in: 1...5)
        
        // When
        guard let manager = self.manager else { return }
        await manager.addNewBook(title: title, author: author, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        let books = await manager.books
        
        // Then
        XCTAssertFalse(books.isEmpty)
        XCTAssertGreaterThan(books.count, 0)
    }
    
    func test_BooksManager_books_shouldBeDeletAnBook() async {
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
        let book = await manager.books[0]
        await manager.delete(book)
        let books = await manager.books
        
        // Then
        XCTAssertTrue(books.isEmpty)
        XCTAssertEqual(books.count, 0)
    }
}
