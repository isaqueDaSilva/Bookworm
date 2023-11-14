//
//  AddNewBookViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

import XCTest
@testable import Bookworm

final class AddNewBookViewModel_Tests: XCTestCase {
    var viewModel: AddNewBookViewModel?
    let manager = BooksMananger()
    func onSave() { print("Save with success.") }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = AddNewBookViewModel(manager: manager, onSave: onSave)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_AddNewBookViewModel_isValid_shouldBeTrue() {
        // Given
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.title = "Title Test"
        viewModel.author = "Author Test"
        viewModel.review = "Review Test"
        
        // Than
        XCTAssertTrue(!viewModel.title.isEmpty)
        XCTAssertTrue(!viewModel.author.isEmpty)
        XCTAssertTrue(!viewModel.review.isEmpty)
        XCTAssertTrue(viewModel.isValid)
    }
    
    func test_AddNewBookViewModel_isValid_shouldBeFalse() {
        // Given
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.title = ""
        viewModel.author = "Author Test"
        viewModel.review = "Review Test"
        
        // Then
        XCTAssertFalse(!viewModel.title.isEmpty)
        XCTAssertFalse(viewModel.author.isEmpty)
        XCTAssertFalse(viewModel.review.isEmpty)
        XCTAssertFalse(viewModel.isValid)
    }
    
    func test_AddNewBookViewModel_showingAlert_shouldBeTrue() {
        // Given
        let displayAlert = true
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.showingAlert = displayAlert
        
        // Then
        XCTAssertTrue(viewModel.showingAlert)
        XCTAssertEqual(viewModel.showingAlert, displayAlert)
    }
    
    func test_AddNewBookViewModel_showingAlert_shouldBeFalse() {
        // Given
        let displayAlert = false
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.showingAlert = displayAlert
        
        // Then
        XCTAssertFalse(viewModel.showingAlert)
        XCTAssertEqual(viewModel.showingAlert, displayAlert)
    }
    
    func test_AddNewBookViewModel_showingAlert_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            // Given
            let displayAlert = false
            
            // When
            guard let viewModel = viewModel else { return }
            viewModel.showingAlert = displayAlert
            
            // Then
            XCTAssertFalse(viewModel.showingAlert)
            XCTAssertEqual(viewModel.showingAlert, displayAlert)
        }
    }
}
