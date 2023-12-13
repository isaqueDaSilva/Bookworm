//
//  BookDetailsViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class BookDetailsViewModel_Tests: XCTestCase {
    
    private var viewModel: BookDetailsViewModel?
    private let book = Book.bookExemple
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.viewModel = BookDetailsViewModel(book: book)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }
    
    func test_BookDetailsViewModel_bookTitle_shouldBeBookTitleIsCorrect() {
        // Given
        // When
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.bookTitle, book.title)
    }
    
    func test_BookDetailsViewModel_bookAuthor_shouldBeBookAuthorIsCorrect() {
        // Given
        // When
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.bookAuthor, book.author.name)
    }
    
    func test_BookDetailsViewModel_bookGenre_shouldBeBookGenreIsCorrect() {
        // Given
        // When
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.bookGenre, book.genre)
    }
    
    func test_BookDetailsViewModel_bookReleaseDate_shouldBeBookReleaseDateIsCorrect() {
        // Given
        // When
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.bookReleaseDate, book.releaseDateFormatted)
    }
    
    func test_BookDetailsViewModel_bookReview_shouldBeBookReviewIsCorrect() {
        // Given
        // When
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.bookReview, book.review)
    }
    
    func test_BookDetailsViewModel_bookRating_shouldBeBookRatingIsCorrect() {
        // Given
        // When
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.bookRating, book.rating)
    }
    
    func test_BookDetailsViewModel_displayAlert_shouldBeDeleteCurrentBookAlertIsTrue() {
        // Given
        // When
        guard let viewModel = viewModel else { return }
        viewModel.displayAlert()
        
        // Then
        XCTAssertTrue(viewModel.deleteCurrentBookAlert)
        XCTAssertEqual(viewModel.deleteCurrentBookAlert, true)
    }
}
