//
//  CategoryRowView.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by Itsuki on 2023/03/06.
//

import SwiftUI

struct RepositoryCategoryRowView: View {
    
    
    var languageName: String
    var repositoryList: [Repository]
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(languageName)
                .font(.system(size: 25))
                .bold()
                .padding(.all, 20)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    ForEach(repositoryList, id: \.id) { repository in
                        let viewModel = RepositoryDetailViewModel(repository: repository)
                        NavigationLink(destination: RepositoryDetailView(viewModel: viewModel)) {
                            RepositoryCategoryItemView(viewModel: viewModel)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }

        }
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    
    static var repositoryCPlus1 = Repository(id: 44838949, fullName: "apple/swift", owner: Owner(id: 10639145, avatarURL: "https://avatars.githubusercontent.com/u/10639145?v=4", url: "https://api.github.com/users/apple"), description: "The Swift Programming Language", createdDateTimeString: "2015-10-23T21:15:07Z", updatedDateTimeString: "2023-03-02T00:54:28Z", stargazersCount: 61951, language: "C++", forks: 9976, openIssues: 6407, watchersCount: 61951)
    
    static var repositoryCPlus2 = Repository(id: 44838950, fullName: "apple/swift", owner: Owner(id: 10639145, avatarURL: "https://avatars.githubusercontent.com/u/10639145?v=4", url: "https://api.github.com/users/apple"), description: "The Swift Programming Language", createdDateTimeString: "2015-10-23T21:15:07Z", updatedDateTimeString: "2023-03-02T00:54:28Z", stargazersCount: 61951, language: "C++", forks: 9976, openIssues: 6407, watchersCount: 61951)
    
    
    static var repositoryList = [repositoryCPlus1, repositoryCPlus2]

        static var previews: some View {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                RepositoryCategoryRowView(
                    languageName: repositoryList[0].language ?? "",
                    repositoryList: Array(repositoryList.prefix(2))
                )
                        
            }
        }
}
