//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
@testable import AmplifyUtilsNotifications
@testable import UserNotifications

final class AUNotificationServiceTests: XCTestCase {
    func testDidReceiveNotificationWithoutRemoteMediaURL() {
        let expect = expectation(description: "Did receive notification")
        let notificationService = AUNotificationService()
        let notificationContent = UNMutableNotificationContent()
        notificationContent.userInfo = [:]
        notificationContent.title = AmplifyTest.randomAlphanumeric()
        notificationContent.subtitle = AmplifyTest.randomAlphanumeric(length: 16)
        notificationContent.body = AmplifyTest.randomAlphanumeric(length: 64)


        let notificationRequest = UNNotificationRequest(
            identifier: AmplifyTest.randomAlphanumeric(),
            content: notificationContent,
            trigger: nil
        )

        notificationService.didReceive(notificationRequest, withContentHandler: { content in
            XCTAssertEqual(content, notificationContent)
            expect.fulfill()
        })
        waitForExpectations(timeout: 1)
    }

    func testDidReceiveNotificationWithRemoteMediaURL() {
        let expect = expectation(description: "Did receive notification")
        let mediaURL = "https://\(AmplifyTest.randomAlphabet()).com/\(AmplifyTest.randomAlphanumeric()).png"
        let mediaData = AmplifyTest.randomAlphanumeric(length: 64).data(using: .utf8)!

        let notificationService = AUNotificationService()
        notificationService.loadDataFromURL = { url in
            XCTAssertEqual(URL(string: mediaURL), url)
            return mediaData
        }

        let notificationContent = UNMutableNotificationContent()
        notificationContent.userInfo = [
            "data": [
                "media-url": mediaURL
            ]
        ]

        let notificationRequest = UNNotificationRequest(
            identifier: AmplifyTest.randomAlphanumeric(),
            content: notificationContent,
            trigger: nil
        )

        notificationService.didReceive(notificationRequest, withContentHandler: { content in
            XCTAssertTrue(!content.attachments.isEmpty)
            let attachment = content.attachments.first!
            XCTAssertTrue(attachment.identifier.hasSuffix(".png"))
            let data = try? Data(contentsOf: attachment.url)
            XCTAssertEqual(mediaData, data)
            expect.fulfill()
        })
        waitForExpectations(timeout: 1)
    }

    func testDidReceiveNotificationWithBrokenRemoteMediaURL() {
        let expect = expectation(description: "Did receive notification")
        let mediaURL = AmplifyTest.randomAlphanumeric()

        let notificationService = AUNotificationService()
        let notificationContent = UNMutableNotificationContent()
        notificationContent.userInfo = [
            "data": [
                "media-url": mediaURL
            ]
        ]

        let notificationRequest = UNNotificationRequest(
            identifier: AmplifyTest.randomAlphanumeric(),
            content: notificationContent,
            trigger: nil
        )

        notificationService.didReceive(notificationRequest, withContentHandler: { content in
            XCTAssertTrue(content.attachments.isEmpty)
            expect.fulfill()
        })
        waitForExpectations(timeout: 1)
    }

    func testDidReceiveNotificationWithRemoteMediaURLAndLoadDataWithError() {
        struct NetworkError: Error { }

        let expect = expectation(description: "Did receive notification")
        let mediaURL = "https://\(AmplifyTest.randomAlphabet()).com/\(AmplifyTest.randomAlphanumeric()).png"

        let notificationService = AUNotificationService()
        notificationService.loadDataFromURL = { url in
            XCTAssertEqual(URL(string: mediaURL), url)
            throw NetworkError()
        }

        let notificationContent = UNMutableNotificationContent()
        notificationContent.userInfo = [
            "data": [
                "media-url": mediaURL
            ]
        ]

        let notificationRequest = UNNotificationRequest(
            identifier: AmplifyTest.randomAlphanumeric(),
            content: notificationContent,
            trigger: nil
        )

        notificationService.didReceive(notificationRequest, withContentHandler: { content in
            XCTAssertTrue(content.attachments.isEmpty)
            expect.fulfill()
        })
        waitForExpectations(timeout: 1)
    }

    func testServiceExtensionTimeWillExpire() {
        let expect = expectation(description: "Service extension time will expire")
        let notificationService = AUNotificationService()
        let notificationContent = UNMutableNotificationContent()
        notificationContent.userInfo = [:]
        notificationContent.title = AmplifyTest.randomAlphanumeric()
        notificationContent.subtitle = AmplifyTest.randomAlphanumeric(length: 16)
        notificationContent.body = AmplifyTest.randomAlphanumeric(length: 64)
        notificationService.didReceive(
            UNNotificationRequest(
                identifier: AmplifyTest.randomAlphanumeric(),
                content: notificationContent,
                trigger: nil
            ),
            withContentHandler: {_ in }
        )

        notificationService.contentHandler = { content in
            XCTAssertEqual(notificationContent, content)
            expect.fulfill()
        }

        notificationService.serviceExtensionTimeWillExpire()
        waitForExpectations(timeout: 1)
    }
}
