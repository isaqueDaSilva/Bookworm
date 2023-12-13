//
//  AddNewBookViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class AddNewBookViewModel_Tests: XCTestCase {
    private var viewModel: AddNewBookViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.viewModel = AddNewBookViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }
    
    func test_AddNewBookViewModel_isValid_shouldBeTrue() {
        // Given
        let newBook = Book.bookExemple
        // When
        guard let viewModel = viewModel else { return }
        viewModel.title = newBook.title
        viewModel.author = newBook.author.name
        viewModel.releaseDate = newBook.releaseDate
        viewModel.genre = newBook.genre
        viewModel.review = newBook.review
        viewModel.rating = newBook.rating
        
        // Than
        XCTAssertFalse(viewModel.title.isEmpty)
        XCTAssertFalse(viewModel.author.isEmpty)
        XCTAssertFalse(viewModel.review.isEmpty)
        XCTAssertTrue(viewModel.isValid)
    }
    
    func test_AddNewBookViewModel_isValid_shouldBeFalse() {
        // Given
        let newBook = Book.bookExemple
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.title = ""
        viewModel.author = newBook.author.name
        viewModel.review = newBook.review
        
        // Then
        XCTAssertTrue(viewModel.title.isEmpty)
        XCTAssertFalse(viewModel.author.isEmpty)
        XCTAssertFalse(viewModel.review.isEmpty)
        XCTAssertFalse(viewModel.isValid)
    }
}
