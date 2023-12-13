//
//  BooksViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

@testable import Bookworm
import XCTest

final class BooksViewModel_Tests: XCTestCase {
    
    private var viewModel: BooksViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = BooksViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }
    
    func test_BooksViewModel_displayAddNewBook_shouldBeTrue() {
        // Given
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.displayAddNewBook()
        
        // Then
        XCTAssertTrue(viewModel.showingAddNewBook)
        XCTAssertEqual(viewModel.showingAddNewBook, true)
    }
    
    func test_BooksViewModel_textColor_shouldBeDisplayTextInRed() {
        // Given
        let rating = Int.random(in: 1...2)
        
        // When
        
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.textColor(rating), .red)
        XCTAssertFalse(viewModel.textColor(rating) == .orange)
        XCTAssertFalse(viewModel.textColor(rating) == .green)
    }
    
    func test_BooksViewModel_textColor_shouldBeDisplayTextInRed_stress() {
        for _ in 0..<10 {
            // Given
            let rating = Int.random(in: 1...2)
            
            // When
            
            // Then
            guard let viewModel = viewModel else { return }
            XCTAssertEqual(viewModel.textColor(rating), .red)
            XCTAssertFalse(viewModel.textColor(rating) == .orange)
            XCTAssertFalse(viewModel.textColor(rating) == .green)
        }
    }
    
    func test_BooksViewModel_textColor_shouldBeDisplayTextInOrange() {
        // Given
        let rating = Int.random(in: 3...4)
        
        // When
        
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.textColor(rating), .orange)
        XCTAssertFalse(viewModel.textColor(rating) == .red)
        XCTAssertFalse(viewModel.textColor(rating) == .green)
    }
    
    func test_BooksViewModel_textColor_shouldBeDisplayTextInOrange_stress() {
        for _ in 0..<10 {
            // Given
            let rating = Int.random(in: 3...4)
            
            // When
            
            // Then
            guard let viewModel = viewModel else { return }
            XCTAssertEqual(viewModel.textColor(rating), .orange)
            XCTAssertFalse(viewModel.textColor(rating) == .red)
            XCTAssertFalse(viewModel.textColor(rating) == .green)
        }
    }
    
    func test_BooksViewModel_textColor_shouldBeDisplayTextInGreen() {
        // Given
        let rating = 5
        
        // When
        
        // Then
        guard let viewModel = viewModel else { return }
        XCTAssertEqual(viewModel.textColor(rating), .green)
        XCTAssertFalse(viewModel.textColor(rating) == .red)
        XCTAssertFalse(viewModel.textColor(rating) == .orange)
    }
}
