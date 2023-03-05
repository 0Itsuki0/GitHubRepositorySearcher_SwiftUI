//
//  RepositoryListViewModel.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/03.
//


import SwiftUI
import Combine


class RepositoryListViewModel: ObservableObject {
    @Published var searchFieldText: String = ""
    @Published var repositoryList = [Repository]()
    @Published var error: Error?
    @Published var isLoading: Bool = false

    
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchRepositoryList() {
        isLoading = true
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: searchFieldText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] response in
                guard let self = self else { return }
                self.isLoading = false
                switch response {
                case .failure(let error):
                    self.error = error
                    return
                case .finished:
                    break
                }
            }, receiveValue: { value in
                self.repositoryList = value.items
                if (value.items.count) == 0 {
                    self.error = GitHubAPIService.ServiceError.noResult as Error
                }
            })
            .store(in: &subscriptions)
    }
    
  
}
