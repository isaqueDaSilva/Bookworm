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
