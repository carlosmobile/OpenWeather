//
//  OpenWeatherUITests.swift
//  OpenWeatherUITests
//
//  Created by Carlos on 26/5/23.
//

import XCTest

class OpenWeatherUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testPullToRefresh() {
        let firstCell = app.tables.children(matching: .cell).element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 0, thenDragTo: finish)
    }

    func testShowCharacterDetail() {
        app.tables.cells.firstMatch.tap()
        let cell = app.tables.children(matching: .cell).element(boundBy: 1)
        cell.swipeLeft()
        cell.swipeLeft()
        cell.swipeLeft()
        cell.tap()
        XCTAssertTrue(cell.exists)
    }
}

