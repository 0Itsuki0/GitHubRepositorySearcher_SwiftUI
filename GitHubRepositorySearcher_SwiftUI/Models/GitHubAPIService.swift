//
//  GitHubAPIService.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/03.
//

import Foundation
import Combine
import SwiftUI


class GitHubAPIService {
    
    
    enum ServiceError: LocalizedError {
        
        case emptyText
        case urlCreation
        case network
        case badRequest
        case parsing
        case noResult
        
        var errorDescription: String? {
            switch self {
            case .emptyText:
                return "Please enter something."
            case .urlCreation:
                return "Something wrong with keyword entered."
            case .network:
                return "Network error: Please check on connection."
            case .badRequest:
                return "Invalid request."
            case .parsing:
                return "Error parsing response."
            case .noResult:
                return "No result Available for the given keyword."
            }
        }  
        
    }
    
    static func gitHubRepositoryPublisher(searchFor text: String) -> AnyPublisher<Response, Error> {
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            return Fail(error: ServiceError.emptyText as Error).eraseToAnyPublisher()
        }
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        guard let urlString = "https://api.github.com/search/repositories?q=\(text)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed), let url = URL(string: urlString)  else {
            return Fail(error: ServiceError.urlCreation as Error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw ServiceError.badRequest
                        }
                    return element.data
                    }
            .decode(type: Response.self, decoder: decoder)
            .catch { error in
                return Fail(error: ServiceError.parsing as Error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

    }
    
    
    static func OwnerAvatarImagePublisher(avatarImageURL: URL) -> AnyPublisher<Image, Error> {
         
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: avatarImageURL)
            .tryMap() {
                guard let uiImage = UIImage(data: $0.data) else {
                    throw ServiceError.badRequest
                }
                return Image(uiImage: uiImage)
            }
            .eraseToAnyPublisher()
    }
    
    
}
