//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//
		

import XCTest

final class IntegrationTestAppUITests: XCTestCase {
    let app = XCUIApplication()
    let timeout = TimeInterval(3)

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        uninstallApp()
    }

    func testRequestNotificationDisplayAlert() throws {
        let button = app.buttons["Default permissions"]
        if button.waitForExistence(timeout: timeout) {
            button.tap()
        } else {
            XCTFail("Fail to find request permission button")
        }

        let alert = XCUIApplication.springboard.alerts.firstMatch
        if alert.waitForExistence(timeout: timeout) {
            let matches = alert.staticTexts.matching(
                NSPredicate(format: "label CONTAINS %@", "Would Like to Send You Notifications")
            )
            XCTAssertTrue(matches.firstMatch.exists)

            let allowButton = alert.buttons["Allow"]
            allowButton.tap()
        } else {
            XCTFail("Failed to find System Permission alert")
        }

        let checkPermissionButton = app.buttons["Is permissions granted?"]
        checkPermissionButton.tap()

        let permissionCheckAlert = app.alerts.firstMatch
        if permissionCheckAlert.waitForExistence(timeout: timeout) {
            XCTAssertNotNil(permissionCheckAlert)
            XCTAssertTrue(permissionCheckAlert.staticTexts.matching(
                NSPredicate(format: "label == %@", "Permissions granted: true")
            ).firstMatch.exists)
        } else {
            XCTFail("No permission check alert found")
        }
    }

    func testRequestNotificationWithPartialPermissions() throws {
        let button = app.buttons["Alert and sound permissions"]
        if button.waitForExistence(timeout: timeout) {
            button.tap()
        } else {
            XCTFail("Fail to find request permission button")
        }

        let alert = XCUIApplication.springboard.alerts.firstMatch
        if alert.waitForExistence(timeout: timeout) {
            let matches = alert.staticTexts.matching(
                NSPredicate(format: "label CONTAINS %@", "Would Like to Send You Notifications")
            )
            XCTAssertTrue(matches.firstMatch.exists)

            let allowButton = alert.buttons["Allow"]
            allowButton.tap()
        } else {
            XCTFail("Failed to find System Permission alert")
        }

        let checkPermissionButton = app.buttons["Is permissions granted?"]
        checkPermissionButton.tap()

        let permissionCheckAlert = app.alerts.firstMatch
        if permissionCheckAlert.waitForExistence(timeout: timeout) {
            XCTAssertNotNil(permissionCheckAlert)
            XCTAssertTrue(permissionCheckAlert.staticTexts.matching(
                NSPredicate(format: "label == %@", "Permissions granted: true")
            ).firstMatch.exists)
        } else {
            XCTFail("No permission check alert found")
        }
    }

    func uninstallApp() {
        let appIcon = XCUIApplication.springboard.icons["IntegrationTestApp"]
        if appIcon.waitForExistence(timeout: timeout) {
            appIcon.press(forDuration: 2)
        } else {
            XCTFail("Failed to find app icon")
        }

        let removeAppButton = XCUIApplication.springboard.buttons["Remove App"]
        if removeAppButton.waitForExistence(timeout: timeout) {
            removeAppButton.tap()
        } else {
            XCTFail("Failed to find 'Remove App'")
        }

        let deleteAppButton = XCUIApplication.springboard.alerts.buttons["Delete App"]
        if deleteAppButton.waitForExistence(timeout: timeout) {
            deleteAppButton.tap()
        } else {
            XCTFail("Failed to find 'Delete App'")
        }

        let finalDeleteButton = XCUIApplication.springboard.alerts.buttons["Delete"]
        if finalDeleteButton.waitForExistence(timeout: timeout) {
            finalDeleteButton.tap()
        } else {
            XCTFail("Failed to find 'Delete'")
        }
    }

}

extension XCUIApplication {
    static var springboard: XCUIApplication {
        XCUIApplication(bundleIdentifier: "com.apple.springboard")
    }
}
