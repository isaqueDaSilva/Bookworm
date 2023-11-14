//
//  BooksViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class BooksViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_BooksViewModel_showingAddNewBook_shouldBeTrue() {
        // Given
        let viewModel = BooksView.BooksViewModel(manager: BooksMananger())
        // When
        viewModel.showingAddNewBook = true
        // Then
        XCTAssertTrue(viewModel.showingAddNewBook)
    }
    
    func test_BooksViewModel_showingAddNewBook_shouldBeFalse() {
        // Given
        let viewModel = BooksView.BooksViewModel(manager: BooksMananger())
        // When
        viewModel.showingAddNewBook = false
        // Then
        XCTAssertFalse(viewModel.showingAddNewBook)
    }
    
    func test_BooksViewModel_showingAddNewBook_shouldBeInjectedValue() {
        // Given
        let showingAddBook = Bool.random()
        // When
        let viewModel = BooksView.BooksViewModel(manager: BooksMananger())
        viewModel.showingAddNewBook = showingAddBook
        // Then
        XCTAssertEqual(viewModel.showingAddNewBook, showingAddBook)
    }

    func test_BooksViewModel_showingAddNewBook_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let showingAddBook = Bool.random()
            // When
            let viewModel = BooksView.BooksViewModel(manager: BooksMananger())
            viewModel.showingAddNewBook = showingAddBook
            // Then
            XCTAssertEqual(viewModel.showingAddNewBook, showingAddBook)
        }
    }
}
