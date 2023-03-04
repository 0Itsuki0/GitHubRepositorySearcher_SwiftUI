//
//  RepositoryViewModel.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/03.
//

import Foundation
import SwiftUI
import Combine

class RepositoryDetailViewModel: ObservableObject {
    @Published var avatarImage: Image
    let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
        self.avatarImage = Image(systemName: "rectangle.on.rectangle.slash")
        fetchAvatarImage(avatarImageURL: repository.avatarImageUrl)
    }
    

    
    private var subscriptions = Set<AnyCancellable>()
    
    private func fetchAvatarImage(avatarImageURL: URL?) {
        guard let avatarImageURL = avatarImageURL else {return}

        GitHubAPIService.OwnerAvatarImagePublisher(avatarImageURL: avatarImageURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let error):
                    print("Failed with error: \(error)")
                    return
                case .finished:
//                    print("Successfully finished!")
                    break
                }
            }, receiveValue: { value in
                self.avatarImage = value
            })
            .store(in: &subscriptions)
    }
    
}
