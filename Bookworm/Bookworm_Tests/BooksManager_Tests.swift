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

    func test_BooksManager_books_shouldBeInitializedEmptyOnFirstLaunchOfTheApp() {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        manager.fetchBooks()
        // Then
        XCTAssertTrue(manager.books.isEmpty)
        XCTAssertEqual(manager.books.count, 0)
    }
    
    func test_BooksManager_books_shouldBeContain1BooksAfterSaving() {
        // Given
        let title = UUID().uuidString
        let author = UUID().uuidString
        let releaseDate = Date.now
        let genre = UUID().uuidString
        let review = UUID().uuidString
        let rating = Int.random(in: 1...5)
        
        // When
        guard let manager = self.manager else { return }
        manager.addNewBook(title: title, author: author, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        
        // Then
        XCTAssertFalse(manager.books.isEmpty)
        XCTAssertGreaterThan(manager.books.count, 0)
    }
    
    func test_BooksManager_books_shouldBeContainSomeBooksAfterSaving_stress() {
        for runs in 1...100 {
            // Given
            let title = UUID().uuidString
            let author = UUID().uuidString
            let releaseDate = Date.now
            let genre = UUID().uuidString
            let review = UUID().uuidString
            let rating = Int.random(in: 1...5)
            
            // When
            guard let manager = self.manager else { return }
            manager.addNewBook(title: title, author: author, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
            
            // Then
            XCTAssertFalse(manager.books.isEmpty)
            XCTAssertGreaterThan(manager.books.count, 0)
            XCTAssertEqual(manager.books.count, runs)
        }
    }
    
    func test_BooksManager_books_shouldBeDeletAnBook() {
        // Given
        guard let manager = self.manager else { return }
        
        let title = UUID().uuidString
        let author = UUID().uuidString
        let releaseDate = Date.now
        let genre = UUID().uuidString
        let review = UUID().uuidString
        let rating = Int.random(in: 1...5)
        manager.addNewBook(title: title, author: author, releaseDate: releaseDate, genre: genre, review: review, rating: rating)
        
        // When
        let book = manager.books[0]
        manager.delete(book)
        
        // Then
        XCTAssertTrue(manager.books.isEmpty)
        XCTAssertEqual(manager.books.count, 0)
    }
}
