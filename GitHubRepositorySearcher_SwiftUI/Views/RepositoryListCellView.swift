//
//  RepositoryListCell.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/03.
//

import SwiftUI

struct RepositoryListCellView: View {
    @ObservedObject var viewModel: RepositoryDetailViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Spacer()

                Text("\(viewModel.repository.fullName)")
                    .bold()
                    .font(.system(size:25))
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(viewModel.repository.description ?? "")
                    .font(.system(size:15))
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.6)
                Spacer()


            }
            .padding(.horizontal, 15)


            Spacer()
            
            Text("\(viewModel.repository.language ?? "")")
                .padding(.trailing, 15)
                .font(.system(size: 20))
        }
        .foregroundColor(.white)
        .frame(height: 90)
    }
        
    init(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
    }
}


struct RepositoryListCellView_Previews: PreviewProvider {

    static var previews: some View {

        let repository = Repository(id: 44838949, fullName: "apple/swift", owner: Owner(id: 10639145, avatarURL: "https://avatars.githubusercontent.com/u/10639145?v=4", url: "https://api.github.com/users/apple"), description: "The Swift Programming Language", createdDateTimeString: "2015-10-23T21:15:07Z", updatedDateTimeString: "2023-03-02T00:54:28Z", stargazersCount: 61951, language: "C++", forks: 9976, openIssues: 6407, watchersCount: 61951)
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            RepositoryListCellView(viewModel: RepositoryDetailViewModel(repository:repository))
                .border(.white)
                    
        }
        
    }
    
}

