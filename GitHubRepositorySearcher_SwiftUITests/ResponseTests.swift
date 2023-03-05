//
//  ResponseTests.swift
//  GitHubRepositorySearcher_SwiftUITests
//
//  Created by イツキ on 2023/03/04.
//

import XCTest
@testable import GitHubRepositorySearcher_SwiftUI

final class ResponseTests: XCTestCase {

    func testResponseCreation() {
        
        let data = dataFrom(filename: "sampleResponse")
        let decoder = JSONDecoder()
        let response = try! decoder.decode(Response.self, from: data)
        XCTAssertEqual(response.totalCount, 265387)
        XCTAssertEqual(response.incompleteResults, false)
        XCTAssertNotNil(response.items)
        
    }

}
