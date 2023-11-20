//
//  BooksViewModel_Tests.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 13/11/23.
//

@testable import Bookworm
import Combine
import XCTest

final class BooksViewModel_Tests: XCTestCase {
    
    var manager = BooksMananger(path: FileManager.documentsDirectoryForTests.appending(component: "SavedTestBooks"))
    var viewModel: BooksViewModel?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = BooksViewModel(manager: manager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Task {
            await manager.removeAllBooksForTest()
            viewModel = nil
        }
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
    
    func test_BooksViewModel_getBooks_shouldBeInitializedEmptyOnFirstLaunchOfTheApp() {
        // Given
        
        // When
        guard let viewModel = viewModel else { return }
        viewModel.getBooks()
        
        // Then
        XCTAssertTrue(viewModel.books.isEmpty)
        XCTAssertEqual(viewModel.books.count, 0)
    }
    
    func test_BooksViewModel_getBooks_shouldBe1BookSavedInFileMangerAfterRelaunchApp() {
        // Given
        
        // When
        guard let viewModel = viewModel else { return }
        let expectation = XCTestExpectation(description: "Should return 1 book after 5 seconds.")
        viewModel.$books
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.addBookForTest()
        viewModel.getBooks()
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.books.isEmpty)
        XCTAssertNotEqual(viewModel.books.count, 0)
        XCTAssertGreaterThan(viewModel.books.count, 0)
        XCTAssertEqual(viewModel.books.count, 1)
        
        XCTAssertFalse(viewModel.genres.isEmpty)
        XCTAssertNotEqual(viewModel.genres.count, 0)
        XCTAssertGreaterThan(viewModel.genres.count, 0)
        XCTAssertEqual(viewModel.genres.count, 1)
        
        XCTAssertFalse(viewModel.authorList.isEmpty)
        XCTAssertNotEqual(viewModel.authorList.count, 0)
        XCTAssertGreaterThan(viewModel.authorList.count, 0)
        XCTAssertEqual(viewModel.authorList.count, 1)
    }
    
    func test_BooksViewModel_getBooks_shouldBe10BooksSavedInFileManagerAfterRelauchApp() {
        // Given
        
        // When
        guard let viewModel = viewModel else { return }
        let expectation = XCTestExpectation(description: "Should return 10 books after 5 seconds.")
        
        viewModel.$books
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.addBookListForTest()
        viewModel.getBooks()
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.books.isEmpty)
        XCTAssertNotEqual(viewModel.books.count, 0)
        XCTAssertGreaterThan(viewModel.books.count, 0)
        XCTAssertEqual(viewModel.books.count, 10)
        
        XCTAssertFalse(viewModel.genres.isEmpty)
        XCTAssertNotEqual(viewModel.genres.count, 0)
        XCTAssertGreaterThan(viewModel.genres.count, 0)
        XCTAssertEqual(viewModel.genres.count, 10)
        
        XCTAssertFalse(viewModel.authorList.isEmpty)
        XCTAssertNotEqual(viewModel.authorList.count, 0)
        XCTAssertGreaterThan(viewModel.authorList.count, 0)
        XCTAssertEqual(viewModel.authorList.count, 10)
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
