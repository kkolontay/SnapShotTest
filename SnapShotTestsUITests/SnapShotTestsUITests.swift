//
//  SnapShotTestsUITests.swift
//  SnapShotTestsUITests
//
//  Created by Kostiantyn Kolontai on 2025-11-25.
//

import XCTest

final class SnapShotTestsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testUI_initialState() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify initial elements exist
        XCTAssertTrue(app.images["globe"].exists, "Globe image should be visible")
        XCTAssertTrue(app.staticTexts["Hello, world!"].exists, "Hello world text should be visible")
        XCTAssertTrue(app.buttons["Push me"].exists, "Push me button should be visible")
    }

    @MainActor
    func testUI_tapButtonShowsSheet() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify button exists
        let pushButton = app.buttons["Push me"]
        XCTAssertTrue(pushButton.exists, "Push me button should exist")

        // Tap the button
        pushButton.tap()

        // Verify sheet appears with content
        XCTAssertTrue(app.staticTexts["Hello, world!"].allElementsBoundByIndex.count >= 2, "Sheet should show additional Hello, world! text")
        XCTAssertTrue(app.buttons["push me again"].waitForExistence(timeout: 2), "Sheet dismiss button should appear")
    }

    @MainActor
    func testUI_tapSheetButtonDismissesSheet() throws {
        let app = XCUIApplication()
        app.launch()

        // Open sheet
        let pushButton = app.buttons["Push me"]
        pushButton.tap()

        // Wait for sheet button
        let sheetButton = app.buttons["push me again"]
        XCTAssertTrue(sheetButton.waitForExistence(timeout: 2), "Sheet button should appear")

        // Tap to dismiss
        sheetButton.tap()

        // Verify sheet is dismissed (button should no longer exist)
        XCTAssertFalse(sheetButton.exists, "Sheet button should no longer exist after dismissal")
    }

    @MainActor
    func testUI_multipleToggleCycles() throws {
        let app = XCUIApplication()
        app.launch()

        let pushButton = app.buttons["Push me"]

        // First cycle: open and close
        pushButton.tap()
        let sheetButton = app.buttons["push me again"]
        XCTAssertTrue(sheetButton.waitForExistence(timeout: 2), "Sheet should open on first tap")
        sheetButton.tap()
        XCTAssertFalse(sheetButton.exists, "Sheet should close")

        // Second cycle: open and close again
        pushButton.tap()
        XCTAssertTrue(sheetButton.waitForExistence(timeout: 2), "Sheet should open on second tap")
        sheetButton.tap()
        XCTAssertFalse(sheetButton.exists, "Sheet should close again")

        // Third cycle: open and verify
        pushButton.tap()
        XCTAssertTrue(sheetButton.waitForExistence(timeout: 2), "Sheet should open on third tap")
    }

    @MainActor
    func testUI_accessibilityElements() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify main button is accessible
        let pushButton = app.buttons["Push me"]
        XCTAssertTrue(pushButton.isEnabled, "Push button should be enabled")
        XCTAssertTrue(pushButton.isHittable, "Push button should be hittable")

        // Open sheet and verify sheet button accessibility
        pushButton.tap()

        let sheetButton = app.buttons["push me again"]
        XCTAssertTrue(sheetButton.waitForExistence(timeout: 2), "Sheet button should exist")
        XCTAssertTrue(sheetButton.isEnabled, "Sheet button should be enabled")
        XCTAssertTrue(sheetButton.isHittable, "Sheet button should be hittable")
    }

    @MainActor
    func testUI_fullUserJourney() throws {
        let app = XCUIApplication()
        app.launch()

        // Verify initial state
        XCTAssertTrue(app.images["globe"].exists, "App should show initial content")

        // Open sheet
        let mainButton = app.buttons["Push me"]
        XCTAssertTrue(mainButton.exists, "Main button should exist")
        mainButton.tap()

        // Interact with sheet
        let sheetButton = app.buttons["push me again"]
        XCTAssertTrue(sheetButton.waitForExistence(timeout: 2), "Sheet should be presented")

        // Close sheet
        sheetButton.tap()

        // Verify back to initial state
        XCTAssertTrue(mainButton.exists, "Should return to initial state")
        XCTAssertFalse(sheetButton.exists, "Sheet should be dismissed")
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
