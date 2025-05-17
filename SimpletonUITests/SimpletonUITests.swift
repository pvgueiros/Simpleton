//
//  SimpletonUITests.swift
//  SimpletonUITests
//
//  Created by Paula Vasconcelos Gueiros on 04/04/25.
//

import XCTest

final class SimpletonUITests: XCTestCase {
    var app = XCUIApplication()
    let defaultTimeout: TimeInterval = 5

    override func setUpWithError() throws {
        app.launch()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

   @MainActor
   func testAppStartsEmpty() {
       XCTAssertEqual(app.images.count, 0, "There should be 0 images when the app is first launched.")
   }
    
    @MainActor
    func testInitialAppLaunch() throws {
        let navigationBar = app.navigationBars["Image Grid"]
        XCTAssertTrue(navigationBar.waitForExistence(timeout: defaultTimeout))
        
        let descriptionText = app.staticTexts["descriptionText"]
        XCTAssertTrue(descriptionText.exists)
        
        let gridView = app.otherElements["gridView"]
        XCTAssertTrue(gridView.exists)
    }
    
    @MainActor
    func testImageDetailNavigation() throws {
        let gridView = app.otherElements["gridView"]
        XCTAssertTrue(gridView.waitForExistence(timeout: defaultTimeout))
        
        app.buttons.matching(identifier: "imageView").element(boundBy: 0).tap()
        
        XCTAssertTrue(app.images.element(boundBy: 0).waitForExistence(timeout: defaultTimeout))
        XCTAssertTrue(app.navigationBars["Image Detail"].exists)
        XCTAssertTrue(app.images["heart"].exists)
        XCTAssertTrue(app.staticTexts["likes"].exists)
        XCTAssertTrue(app.staticTexts["username"].exists)
        XCTAssertTrue(app.staticTexts["title"].exists)
        
        app.buttons["Image Grid"].tap()
        
        XCTAssertTrue(app.navigationBars["Image Grid"].exists)
    }
}
