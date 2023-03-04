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
    @Published var results = [Repository]()

    
    var categories: [String: [Repository]] {
            Dictionary(
                grouping: results,
                by: { $0.language ?? "" }
            )
        }

    
    private var subscriptions = Set<AnyCancellable>()
    
    func fetchRepositoryList() {
        GitHubAPIService.gitHubRepositoryPublisher(searchFor: searchFieldText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let error):
                    print("Failed with error: \(error)")
                    return
                case .finished:
                    print("Successfully finished!")
                }
            }, receiveValue: { value in
                self.results = value.items
            })
            .store(in: &subscriptions)
    }
    
    
    init(scheduler: DispatchQueue = DispatchQueue(label: "RepositoryListViewModel")) {
        self.fetchRepositoryList()
    }
    
  
}
