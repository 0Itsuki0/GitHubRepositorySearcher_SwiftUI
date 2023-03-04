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
    
    enum ServiceError: Error, CustomStringConvertible {
        case urlCreation
        case network
        case badRequest
        case parsing
        
        var description: String {
            switch self {
            case .urlCreation:
                return "Something wrong with keyword entered."
            case .network:
                return "Network error: Please check on connection."
            case .badRequest:
                return "Invalid request."
            case .parsing:
                return "Error parsing response."
            }
        }
    }
    
    static func gitHubRepositoryPublisher(searchFor text: String) -> AnyPublisher<Response, Error> {
         
        let session = URLSession.shared
        let decoder = JSONDecoder()
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(text)") else { return Fail(error: ServiceError.urlCreation as Error).eraseToAnyPublisher()}
        
        return session.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                    return element.data
                    }
            .decode(type: Response.self, decoder: decoder)
            .eraseToAnyPublisher()
        
    }
    
    static func OwnerAvatarImagePublisher(avatarImageURL: URL) -> AnyPublisher<Image, Error> {
         
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: avatarImageURL)
            .tryMap() {
                guard let uiImage = UIImage(data: $0.data) else {
                    throw URLError(.badServerResponse)
                }
                return Image(uiImage: uiImage)
            }
            .eraseToAnyPublisher()
    }
    
    
}
