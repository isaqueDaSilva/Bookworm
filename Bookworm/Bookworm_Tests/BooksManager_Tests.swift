//
//  BooksManager_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class BooksManager_Tests: XCTestCase {

    var pathTemporary = FileManager.documentsDirectoryForTests
    var manager: BooksManager?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.manager = BooksManager(url: pathTemporary)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.manager = nil
    }

    func test_BooksManager_getBooks_shouldBeInitializedEmptyOnFirstLaunchOfTheApp() async {
        // Given
        
        // When
        guard let manager = self.manager else { return }
        let books = await manager.getBooks()
        
        // Then
        XCTAssertTrue(books.isEmpty)
        XCTAssertEqual(books.count, 0)
    }
    
    func test_BooksManager_getBooks_shouldBe1BookSavedInFileMangerAfterRelaunchApp() async {
        // Given
        let newBook = Book.bookExemple
        
        guard let manager = self.manager else { return }
        
        await manager.addNewBook(
            title: newBook.title,
            authorName: newBook.author.name,
            releaseDate: newBook.releaseDate,
            genre: newBook.genre,
            review: newBook.review,
            rating: newBook.rating
        )
        // When
        let books = await manager.getBooks()
        
        // Then
        XCTAssertFalse(books.isEmpty)
        XCTAssertGreaterThan(books.count, 0)
        XCTAssertEqual(books.count, 1)
    }
    
    func test_BooksManager_getBooks_shouldBe10BooksSavedInFileManagerAfterRelauchApp() async {
        // Given
        let newBookList = Book.bookListExemples
        guard let manager = self.manager else { return }
        
        for book in newBookList {
            await manager.addNewBook(
                title: book.title,
                authorName: book.author.name,
                releaseDate: book.releaseDate,
                genre: book.genre,
                review: book.review,
                rating: book.rating
            )
        }
        // When
        let books = await manager.getBooks()
        
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
        
        // Then
        let books = await manager.getBooks()
        
        XCTAssertFalse(books.isEmpty)
        XCTAssertGreaterThan(books.count, 0)
        XCTAssertEqual(books.count, 1)
        XCTAssertEqual(books[0], newBook)
    }
    
    func test_BooksManager_deleteBook_shouldBeBooksArrayEmptyAfterMethodCalled() async {
        // Given
        let newBook = Book.bookExemple
        
        guard let manager = self.manager else { return }
        
        await manager.addNewBook(
            title: newBook.title,
            authorName: newBook.author.name,
            releaseDate: newBook.releaseDate,
            genre: newBook.genre,
            review: newBook.review,
            rating: newBook.rating
        )
        
        let books1 = await manager.getBooks()
        
        // When
        guard let bookSelected = books1.first else { return }
        await manager.deleteBook(bookSelected)
        
        let books2 = await manager.getBooks()
        // Then
        XCTAssertTrue(books2.isEmpty)
        XCTAssertEqual(books2.count, 0)
    }
    
    func test_BooksManager_deleteBook_shouldBeBooksArrayContaining1LessBookAfterMethodCalled() async {
        // Given
        let newBookList = Book.bookListExemples
        guard let manager = self.manager else { return }
        
        for book in newBookList {
            await manager.addNewBook(
                title: book.title,
                authorName: book.author.name,
                releaseDate: book.releaseDate,
                genre: book.genre,
                review: book.review,
                rating: book.rating
            )
        }
        // When
        let books = await manager.getBooks()
        
        // When
        let book = books.randomElement()
        guard let bookSelected = book else { return }
        await manager.deleteBook(bookSelected)
        
        let books2 = await manager.getBooks()
        // Then
        XCTAssertFalse(books2.isEmpty)
        XCTAssertGreaterThan(books2.count, 0)
        XCTAssertEqual(books2.count, 9)
        XCTAssertFalse(books2.contains(bookSelected))
    }
}
