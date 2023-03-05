//
//  LocalizedAlertError.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/04.
//

import Foundation

// helper struct on displaying customized error as alert
struct LocalizedAlertError: LocalizedError {
    let underlyingError: LocalizedError
    
    var errorDescription: String? {
        underlyingError.localizedDescription
    }
    
    var recoverySuggestion: String = ""

    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        underlyingError = localizedError
    }
}
