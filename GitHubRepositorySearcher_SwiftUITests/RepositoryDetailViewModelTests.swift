//
//  RepositoryDetailViewModelTests.swift
//  GitHubRepositorySearcher_SwiftUITests
//
//  Created by イツキ on 2023/03/04.
//

import XCTest
import Combine
import SwiftUI
@testable import GitHubRepositorySearcher_SwiftUI


final class RepositoryDetailViewModelTests: XCTestCase {
    
    private var subscriptions: Set<AnyCancellable>!
 
    var viewModel: RepositoryDetailViewModel!
    var repository: Repository!
    
    
    
    override func setUpWithError() throws {
        super.setUp()
        subscriptions = []
 
        repository = Repository(id: 44838949, fullName: "apple/swift", owner: Owner(id: 10639145, avatarURL: "", url: "https://api.github.com/users/apple"), description: "The Swift Programming Language", createdDateTimeString: "2015-10-23T21:15:07Z", updatedDateTimeString: "2023-03-02T00:54:28Z", stargazersCount: 61951, language: "C++", forks: 9976, openIssues: 6407, watchersCount: 61951)
        
        viewModel = RepositoryDetailViewModel(repository: repository)
       
    }
    
    
    
    func testRepositoryDetailViewModelInitialization() {
        let expectation = XCTestExpectation(description: "Fetching avatar image ")
        
            let subscriber = self.viewModel.$avatarImage.sink { _ in
                guard self.viewModel.avatarImage != nil else { return }
                expectation.fulfill()
            }
            
        wait(for: [expectation], timeout: 10)
        subscriber.cancel()
        XCTAssertEqual(viewModel.avatarImage, Image(systemName: "rectangle.on.rectangle.slash"))

    }
    
    
    override func tearDown() {
        super.tearDown()
    }
    
}
