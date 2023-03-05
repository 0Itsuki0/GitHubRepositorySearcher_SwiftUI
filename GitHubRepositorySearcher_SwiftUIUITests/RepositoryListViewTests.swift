//
//  RepositoryListViewTests.swift
//  GitHubRepositorySearcher_SwiftUIUITests
//
//  Created by イツキ on 2023/03/05.
//

import XCTest

final class RepositoryListViewTests: XCTestCase {
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
        XCTAssertTrue(searchField.exists, "The searchField exists.")
        
        let clearButton = app.buttons["clearButton"]
        XCTAssertTrue(clearButton.exists, "The clearButton exists.")
        
        let searchButton = app.buttons["searchButton"]
        XCTAssertTrue(searchButton.exists, "The searchButton exists.")

    }
    
    
    func testRepositoryListViewInteraction() {
        
        let searchField = app.textFields["searchField"]
        searchField.tap()
        searchField.typeText("swift")
        
        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
        
        let repositoryListView = app.scrollViews["repositoryListView"]
        XCTAssertTrue(repositoryListView.exists, "The repository list tableview exists.")
        let repositoryCells = repositoryListView.otherElements
        XCTAssertTrue(repositoryCells.firstMatch.waitForExistence(timeout: 10))
        
        if repositoryCells.count > 0 {
            let count: Int = (repositoryCells.count - 1)
         
            let promise = expectation(description: "Wait for table cells")
         
            for i in stride(from: 0, to: count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let repositoryCell = repositoryCells.element(boundBy: i)
                XCTAssertTrue(repositoryCell.exists, "The \(i) cell is in place on the table")
                
                let repositoryCellNameLabel = repositoryCell.staticTexts["RepositoryCellNameLabel"]
                XCTAssertTrue(repositoryCellNameLabel.exists, "The repository cell name label exists.")
                
                let repositoryCellDescriptionLabel = repositoryCell.staticTexts["RepositoryCellDescriptionLabel"]
                XCTAssertTrue(repositoryCellDescriptionLabel.exists, "The repository cell description label exists.")
                
                let repositoryCellLanguageLabel = repositoryCell.staticTexts["RepositoryCellLanguageLabel"]
                XCTAssertTrue(repositoryCellLanguageLabel.exists, "The repository cell language label exists.")
                
                repositoryCell.tap()
         
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating cells. ")
         
        } else {
            XCTAssert(false, "Was not able to find any cells. ")
        }
        
    }
    
    func testRepositoryListViewLoader() {
        let searchField = app.textFields["searchField"]
        searchField.tap()
        searchField.typeText("swift")
        
        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
        
        let loader = app.otherElements["loader"]
        XCTAssertTrue(loader.waitForExistence(timeout: 2))

    }
    
    
    func testRepositoryListViewErrorAlert() {
        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists, "The alert exists.")
        XCTAssertTrue(alert.label == "Please enter something.")
        alert.buttons.firstMatch.tap()
        XCTAssertFalse(alert.exists, "The alert disappeared.")

    }
    
}
