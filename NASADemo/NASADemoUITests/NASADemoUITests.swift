//
//  NASADemoUITests.swift
//  NASADemoUITests
//
//  Created by Navjot Cheema on 2023-07-10.
//

import XCTest

final class NASADemoUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testWelcome() throws {
        let app = XCUIApplication()
        app.launch()
        let title = app.staticTexts["NASA"]
        XCTAssert(title.exists)
    }
    
}
