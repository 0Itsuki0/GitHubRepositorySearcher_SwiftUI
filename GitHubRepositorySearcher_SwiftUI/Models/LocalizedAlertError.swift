//
//  LocalizedAlertError.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/04.
//

import Foundation

struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError
    
    var errorDescription: String? {
        underlyingError.localizedDescription
    }
    
    var recoverySuggestion: String = ""

    init?(error: GitHubAPIService.ServiceError?) {
        guard let localizedError = error else { return nil }
        underlyingError = localizedError
    }
}
