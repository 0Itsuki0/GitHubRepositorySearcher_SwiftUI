//
//  GitHubAPIServiceTests.swift
//  GitHubRepositorySearcher_SwiftUITests
//
//  Created by イツキ on 2023/03/04.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift
import Combine
import SwiftUI
@testable import GitHubRepositorySearcher_SwiftUI


final class GitHubAPIServiceTests: XCTestCase {
    private var subscriptions: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        super.setUp()
        subscriptions = []
    }


    // tests for gitHubRepositoryPublisher function
    
    func testGitHubRepositoryPublisherSuccess() {
            
        var repositoryList = [Repository]()
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching repositories. ")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponse.json", type(of: self))!,
                statusCode: 200,
                headers: nil
            )
        }
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: "swift")
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                repositoryList = value.items
                if (value.items.count) == 0 {
                    error = GitHubAPIService.ServiceError.noResult as Error
                }
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(error)
        XCTAssertEqual(repositoryList.count, 30)
        XCTAssertEqual(repositoryList.first?.id, 44838949)
    }
    
    
    
    func testGitHubRepositoryPublisherEmptyText() {
            
        var repositoryList = [Repository]()
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching repositories. ")
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: "")
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                repositoryList = value.items
                if (value.items.count) == 0 {
                    error = GitHubAPIService.ServiceError.noResult as Error
                }
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, GitHubAPIService.ServiceError.emptyText.errorDescription)
        XCTAssertEqual(repositoryList.count, 0)

    }
    
    func testGitHubRepositoryPublisherNoResult() {
            
        var repositoryList = [Repository]()
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching repositories. ")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponseNoResult.json", type(of: self))!,
                statusCode: 200,
                headers: nil
            )
        }
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: "^^7878789283746^^^^^^^^^****?//qqq")
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                repositoryList = value.items
                if (value.items.count) == 0 {
                    error = GitHubAPIService.ServiceError.noResult as Error
                }
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, GitHubAPIService.ServiceError.noResult.errorDescription)
        XCTAssertEqual(repositoryList.count, 0)

    }
    
    
    
    func testGitHubRepositoryPublisherNetworkError() {
            
        var repositoryList = [Repository]()
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching repositories. ")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
              return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponse.json", type(of: self))!,
                statusCode:200,
                headers:nil
              ).requestTime(200.0, responseTime: 5.0)
        }
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: "swift")
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                repositoryList = value.items
                if (value.items.count) == 0 {
                    error = GitHubAPIService.ServiceError.noResult as Error
                }
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 300)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, GitHubAPIService.ServiceError.network.errorDescription)
        XCTAssertEqual(repositoryList.count, 0)

    }
    
    func testGitHubRepositoryPublisherBadRequest() {
            
        var repositoryList = [Repository]()
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching repositories. ")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponseBadRequest.json", type(of: self))!,
                statusCode: 422,
                headers: nil
            )
        }
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: "swift")
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                repositoryList = value.items
                if (value.items.count) == 0 {
                    error = GitHubAPIService.ServiceError.noResult as Error
                }
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, GitHubAPIService.ServiceError.badRequest.errorDescription)
        XCTAssertEqual(repositoryList.count, 0)
    }

    
    func testGitHubRepositoryPublisherParsingError() {
            
        var repositoryList = [Repository]()
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching repositories. ")
        stub(condition: isHost("api.github.com") && isPath("/search/repositories") ) { _ in
            return HTTPStubsResponse(
                fileAtPath: OHPathForFile("sampleResponseParsingError.json", type(of: self))!,
                statusCode: 200,
                headers: nil
            )
        }
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: "swift")
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                repositoryList = value.items
                if (value.items.count) == 0 {
                    error = GitHubAPIService.ServiceError.noResult as Error
                }
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, GitHubAPIService.ServiceError.parsing.errorDescription)
        XCTAssertEqual(repositoryList.count, 0)
    }
   
    
    
    
    // tests for OwnerAvatarImagePublisher function
    func testOwnerAvatarImagePublisherSuccess() {
            
        var avatarImage: Image?
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching image. ")
        let imageData = UIImage(systemName: "paperplane")!.pngData()!
        stub(condition: isHost("avatars.githubusercontent.com")) { _ in
            return HTTPStubsResponse(
                data: imageData,
                statusCode: 200,
                headers: nil
            )
        }
        GitHubAPIService.ownerAvatarImagePublisher(avatarImageURL: URL(string: "https://avatars.githubusercontent.com/u/373016?v=4")!)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                avatarImage = value
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(error)
        XCTAssertNotNil(avatarImage)
        
    }
    
    
    // tests for OwnerAvatarImagePublisher function
    func testOwnerAvatarImagePublisherNetworkError() {
            
        var avatarImage: Image?
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching image. ")
        let imageData = UIImage(systemName: "paperplane")!.pngData()!
        stub(condition: isHost("avatars.githubusercontent.com")) { _ in
            return HTTPStubsResponse(
                data: imageData,
                statusCode: 200,
                headers: nil
            ).requestTime(200.0, responseTime: 5.0)
        }
        GitHubAPIService.ownerAvatarImagePublisher(avatarImageURL: URL(string: "https://avatars.githubusercontent.com/u/373016?v=4")!)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                avatarImage = value
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 300)
        XCTAssertNotNil(error)
        XCTAssertNil(avatarImage)
        XCTAssertEqual(error?.localizedDescription, GitHubAPIService.ServiceError.network.errorDescription)
    }
    
    
    
    // tests for OwnerAvatarImagePublisher function
    func testOwnerAvatarImagePublisherBadRequest() {
            
        var avatarImage: Image?
        var error: Error?
        
        let expectation = XCTestExpectation(description: "Create publisher for fetching image. ")
        let imageData = Data()
        stub(condition: isHost("avatars.githubusercontent.com")) { _ in
            return HTTPStubsResponse(
                data: imageData,
                statusCode: 200,
                headers: nil
            )
        }
        GitHubAPIService.ownerAvatarImagePublisher(avatarImageURL: URL(string: "https://avatars.githubusercontent.com/u/373016?v=4")!)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let encounteredError):
                    error = encounteredError
                case .finished:
                    break
                }
                expectation.fulfill()

            }, receiveValue: { value in
                avatarImage = value
            })
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNotNil(error)
        XCTAssertNil(avatarImage)
        XCTAssertEqual(error?.localizedDescription, GitHubAPIService.ServiceError.badRequest.errorDescription)
    }
    

    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }

    
    
    
}
