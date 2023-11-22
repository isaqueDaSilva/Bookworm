//
//  BooksView_UITest.swift
//  Bookworm_UITests
//
//  Created by Isaque da Silva on 20/11/23.
//

import XCTest

final class BooksView_UITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_BooksView_AddNewBookButton_shouldBeDisplayAddNewBookView() {
        let navBar = app.navigationBars["Bookworm"]
        let button = navBar.buttons["AddNewBookButton"]
        button.tap()
        
        XCTAssertTrue(button.exists)
    }
}
