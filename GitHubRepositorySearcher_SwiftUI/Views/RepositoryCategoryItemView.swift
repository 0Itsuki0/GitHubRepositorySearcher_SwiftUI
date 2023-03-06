//
//  RepositoryCategoryItemView.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by Itsuki on 2023/03/06.
//

import SwiftUI

struct RepositoryCategoryItemView: View {
    
    @ObservedObject var viewModel: RepositoryDetailViewModel

    
    var body: some View {
            VStack(alignment: .center) {
                viewModel.avatarImage
                    .resizable()
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
                    .scaledToFit()
                Text(viewModel.repository.fullName)
                    .font(.system(size: 20))
                    .bold()
                    .padding(.top, 10)
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.8)
                    .frame(maxWidth: 160)
            }
            .padding(.all, 15)
            .border(.white)
        }
}

struct RepositoryCategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        let repository = Repository(id: 44838949, fullName: "apple/swift", owner: Owner(id: 10639145, avatarURL: "https://avatars.githubusercontent.com/u/10639145?v=4", url: "https://api.github.com/users/apple"), description: "The Swift Programming Language", createdDateTimeString: "2015-10-23T21:15:07Z", updatedDateTimeString: "2023-03-02T00:54:28Z", stargazersCount: 61951, language: "C++", forks: 9976, openIssues: 6407, watchersCount: 61951)
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            RepositoryCategoryItemView(viewModel: RepositoryDetailViewModel(repository:repository))
                    
        }
    }
}
