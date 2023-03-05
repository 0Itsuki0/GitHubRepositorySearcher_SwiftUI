//
//  XCTestCase+Utils.swift
//  GitHubRepositorySearcher_SwiftUITests
//
//  Created by イツキ on 2023/03/04.
//

import XCTest


extension XCTestCase {
   func dataFrom(filename: String) -> Data {
        let path = Bundle(for: GitHubRepositorySearcher_SwiftUITests.self).path(forResource: filename, ofType: "json")!
        return NSData(contentsOfFile: path)! as Data
    }
}

