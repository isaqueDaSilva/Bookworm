//
//  BooksManager_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class BooksManager_Tests: XCTestCase {

    var pathTemporary = FileManager.documentsDirectoryForTests.appending(path: "SavedTestBooks")
    var manager: BooksMananger?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.manager = BooksMananger(path: pathTemporary)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Task {
            guard let manager = manager else { return }
            await manager.removeAllBooksForTest()
            self.manager = nil
        }
    }

    func test_BooksManager_fetchBooks_shouldBeInitializedEmptyOnFirstLaunchOfTheApp() async {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        await manager.fetchBooks()
        let books = await manager.books
        // Then
        XCTAssertTrue(books.isEmpty)
        XCTAssertEqual(books.count, 0)
    }
    
    func test_BooksManager_fetchBooks_shouldBe1BookSavedInFileMangerAfterRelaunchApp() async {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        await manager.addBookForTest()
        await manager.fetchBooks()
        let books = await manager.books
        
        // Then
        XCTAssertFalse(books.isEmpty)
        XCTAssertGreaterThan(books.count, 0)
        XCTAssertEqual(books.count, 1)
    }
    
    func test_BooksManager_fetchBooks_shouldBe10BooksSavedInFileManagerAfterRelauchApp() async {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        await manager.addBookListForTest()
        await manager.fetchBooks()
        let books = await manager.books
        
        // Then
        XCTAssertFalse(books.isEmpty)
        XCTAssertGreaterThan(books.count, 0)
        XCTAssertEqual(books.count, 10)
        
    }
    
    func test_BooksManager_addNewBook_shouldBeDisplayedBooksArrayContaining1BookAfterMethodCalled() async {
        // Given
        let newBook = Book.bookExemple
        
        // When
        guard let manager = manager else { return }
        await manager.addNewBook(title: newBook.title, authorName: newBook.author.name, releaseDate: newBook.releaseDate, genre: newBook.genre, review: newBook.review, rating: newBook.rating)
        let books = await manager.books
        
        // Then
        XCTAssertFalse(books.isEmpty)
        XCTAssertGreaterThan(books.count, 0)
        XCTAssertEqual(books.count, 1)
        XCTAssertEqual(books[0], newBook)
    }
    
    func test_BooksManager_delete_shouldBeBooksArrayEmptyAfterMethodCalled() async {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        await manager.addBookForTest()
        let book = await manager.books[0]
        await manager.delete(book)
        let books = await manager.books
        
        // Then
        XCTAssertTrue(books.isEmpty)
        XCTAssertEqual(books.count, 0)
    }
    
    func test_BooksManager_delete_shouldBeBooksArrayContaining1LessBookAfterMethodCalled() async {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        await manager.addBookListForTest()
        
        let book = await manager.books.randomElement()
        
        guard let bookSelected  = book else { return }
        
        await manager.delete(bookSelected)
        let books = await manager.books
        
        // Then
        XCTAssertFalse(books.isEmpty)
        XCTAssertGreaterThan(books.count, 0)
        XCTAssertEqual(books.count, 9)
        XCTAssertFalse(books.contains(bookSelected))
    }
}
