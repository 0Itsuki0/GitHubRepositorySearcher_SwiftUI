//
//  GitHubRepositorySearcher_SwiftUIUITestsLaunchTests.swift
//  GitHubRepositorySearcher_SwiftUIUITests
//
//  Created by イツキ on 2023/03/03.
//

import XCTest

final class GitHubRepositorySearcher_SwiftUIUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
