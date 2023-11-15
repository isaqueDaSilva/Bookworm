//
//  BooksViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class BooksViewModel_Tests: XCTestCase {
    
    var viewModel: BooksViewModel?
    let manager = BooksMananger(stack: CoreDataTestStack())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = BooksViewModel(manager: manager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_BooksViewModel_displayAddNewBook_shouldBeDefiningShowingAddNewBookAsTrue() {
        // Given
        
        // When
        guard let viewModel = self.viewModel else { return }
        
        viewModel.displayAddNewBook()
        // Then
        XCTAssertTrue(viewModel.showingAddNewBook)
    }
    
    func test_BooksViewModel_showingAddNewBook_shouldBeInitializedAsFalse() {
        // Given
        
        // When
        guard let viewModel = self.viewModel else { return }
        
        // Then
        XCTAssertFalse(viewModel.showingAddNewBook)
    }
    
    
}
