//
//  RepositoryDetailViewTests.swift
//  GitHubRepositorySearcher_SwiftUIUITests
//
//  Created by イツキ on 2023/03/05.
//

import XCTest

final class RepositoryDetailViewTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    override func tearDownWithError() throws {
        
        app.terminate()
        app = nil
        try super.tearDownWithError()
        
    }
    
    func testRepositoryListViewInitialization() {
        let searchField = app.textFields["searchField"]
        searchField.tap()
        searchField.typeText("swift")
        
        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
        
        let repositoryListView = app.scrollViews["repositoryListView"]
        let repositoryCells = repositoryListView.otherElements
        XCTAssertTrue(repositoryCells.firstMatch.waitForExistence(timeout: 10))
        repositoryCells.firstMatch.tap()
        
        let repositoryDetailAvatarImageView = app.images["RepositoryDetailAvatarImageView"]
        XCTAssertTrue(repositoryDetailAvatarImageView.exists, "The avatar image view exists.")
        
        let repositoryDetailNameLabel = app.staticTexts["RepositoryDetailNameLabel"]
        XCTAssertTrue(repositoryDetailNameLabel.exists, "The repository name label exists.")
        
        let repositoryDetailDescriptionLabel = app.staticTexts["RepositoryDetailDescriptionLabel"]
        XCTAssertTrue(repositoryDetailDescriptionLabel.exists, "The repository description label exists.")
        
        let repositoryDetailLanguageLabel = app.staticTexts["RepositoryDetailLanguageLabel"]
        XCTAssertTrue(repositoryDetailLanguageLabel.exists, "The repository language label exists.")
        
        let repositoryDetailOpenIssuesCountLabel = app.staticTexts["RepositoryDetailOpenIssuesCountLabel"]
        XCTAssertTrue(repositoryDetailOpenIssuesCountLabel.exists, "The open issues count label exists.")
        
        let repositoryDetailWatchersCountLabel = app.staticTexts["RepositoryDetailWatchersCountLabel"]
        XCTAssertTrue(repositoryDetailWatchersCountLabel.exists, "The watchers count label exists.")
        
        let repositoryDetailStarCountLabel = app.staticTexts["RepositoryDetailStarCountLabel"]
        XCTAssertTrue(repositoryDetailStarCountLabel.exists, "The star count label exists.")
        
        let repositoryDetailForksCountLabel = app.staticTexts["RepositoryDetailForksCountLabel"]
        XCTAssertTrue(repositoryDetailForksCountLabel.exists, "The forks count label exists.")
       
    }

    
}
