//
//  RepositoryListViewModelTests.swift
//  GitHubRepositorySearcher_SwiftUITests
//
//  Created by イツキ on 2023/03/04.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
import Combine
@testable import GitHubRepositorySearcher_SwiftUI

final class RepositoryListViewModelTests: XCTestCase {
    
    private var subscriptions: Set<AnyCancellable>!
    var viewModel: RepositoryListViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        subscriptions = []
        viewModel = RepositoryListViewModel()

    }
    

    func testRepositoryListViewModelSuccess() {
        
        let expectation = XCTestExpectation(description: "Fetching repositories. ")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
              return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponse.json", type(of: self))!,
                statusCode:200,
                headers:nil
              ).requestTime(0.0, responseTime: 0.0)
        }
        
            let subscriber = self.viewModel.$isLoading.sink { _ in
                guard self.viewModel.repositoryList.count != 0 else { return }
                        expectation.fulfill()
                    }
        viewModel.searchFieldText = "swift"
        viewModel.fetchRepositoryList()
        
        wait(for: [expectation], timeout: 10)
        subscriber.cancel()

        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.repositoryList.count, 30)
        XCTAssertEqual(viewModel.repositoryList.first?.id, 44838949)

        
    }
    
    
    func testRepositoryListViewModelError() {
        
        let expectation = XCTestExpectation(description: "Fetching repositories resulting error. ")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
              return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponseNoResult.json", type(of: self))!,
                statusCode:200,
                headers:nil
              ).requestTime(0.0, responseTime: 0.0)
        }
        
            let subscriber = self.viewModel.$isLoading.sink { _ in
                guard self.viewModel.error != nil else { return }
                        expectation.fulfill()
                    }
        viewModel.searchFieldText = "^^7878789283746^^^^^^^^^****?//qqq"
        viewModel.fetchRepositoryList()
        
        wait(for: [expectation], timeout: 10)
        subscriber.cancel()

        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error?.localizedDescription, GitHubAPIService.ServiceError.noResult.errorDescription)
        XCTAssertEqual(viewModel.repositoryList.count, 0)

        
    }
    

    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }

    
    
}
