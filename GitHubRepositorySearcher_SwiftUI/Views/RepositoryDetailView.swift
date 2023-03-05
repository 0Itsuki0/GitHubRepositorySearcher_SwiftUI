//
//  RepositoryDetailView.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/03.
//

import SwiftUI

struct RepositoryDetailView: View {
    @ObservedObject var viewModel: RepositoryDetailViewModel

   var body: some View {
       ZStack {
           Background
               .ignoresSafeArea()
           
        
           VStack(alignment: .center) {
               AvatarIcon
                   .padding(.horizontal, 20)
               
               Spacer()
               
               Description
                   .padding(.top, 20)
                   .padding(.horizontal, 20)
               
               
               Spacer()

               
               MoreInformations
                   .padding(.top, 10)
                   .padding(.horizontal, 40)
                   .padding(.bottom, 40)
               
           }
       }
   }
}

extension RepositoryDetailView {
    
    var Background: some View {
        LinearGradient(colors: [Color(red: 71/255, green: 110/255, blue: 168/255),
                                Color(red: 6/255, green: 9/255, blue: 28/255)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        
    }
    
    var AvatarIcon: some View {
        VStack(alignment: .center) {
            (viewModel.avatarImage ?? Image(systemName: "rectangle.on.rectangle.slash"))
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 40.0)
                .padding(.top, 50)
                .padding(.bottom, 15)
                .accessibilityIdentifier("RepositoryDetailAvatarImageView")
            Text("\(viewModel.repository.fullName)")
                .bold()
                .accessibilityIdentifier("RepositoryDetailNameLabel")
        }
        .foregroundColor(.white)
        .font(.system(size: 25))
    }
    
    
    var Description: some View {
        Text("\(viewModel.repository.description ?? "No Description available")")
            .font(.system(size: 15))
            .minimumScaleFactor(0.6)
            .multilineTextAlignment(.leading)
            .foregroundColor(.white)
            .accessibilityIdentifier("RepositoryDetailDescriptionLabel")
    
    }
    
    
    var MoreInformations: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("language")
                    .padding(.bottom, 0.5)
                Text("Stars Count")
                    .padding(.bottom, 0.5)
                Text("Watchers Count")
                    .padding(.bottom, 0.5)
                Text("Open Issues")
                    .padding(.bottom, 0.5)
                Text("Forks")
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(viewModel.repository.language ?? "")
                    .padding(.bottom, 0.5)
                    .accessibilityIdentifier("RepositoryDetailLanguageLabel")
                Text("\(viewModel.repository.stargazersCount ?? 0)")
                    .padding(.bottom, 0.5)
                    .accessibilityIdentifier("RepositoryDetailStarCountLabel")
                Text("\(viewModel.repository.watchersCount ?? 0)")
                    .padding(.bottom, 0.5)
                    .accessibilityIdentifier("RepositoryDetailWatchersCountLabel")
                Text("\(viewModel.repository.openIssues ?? 0)")
                    .padding(.bottom, 0.5)
                    .accessibilityIdentifier("RepositoryDetailOpenIssuesCountLabel")
                Text("\(viewModel.repository.forks ?? 0)")
                    .padding(.bottom, 0.5)
                    .accessibilityIdentifier("RepositoryDetailForksCountLabel")
            }
        }
        .foregroundColor(.white)
        .font(.system(size: 17))
        .minimumScaleFactor(0.6)
    }
    
}

struct RepositoryDetailView_Previews: PreviewProvider {

    static var previews: some View {

        let repository = Repository(id: 44838949, fullName: "apple/swift", owner: Owner(id: 10639145, avatarURL: "https://avatars.githubusercontent.com/u/10639145?v=4", url: "https://api.github.com/users/apple"), description: "The Swift Programming Language", createdDateTimeString: "2015-10-23T21:15:07Z", updatedDateTimeString: "2023-03-02T00:54:28Z", stargazersCount: 61951, language: "C++", forks: 9976, openIssues: 6407, watchersCount: 61951)
        
        RepositoryDetailView(viewModel: RepositoryDetailViewModel(repository:repository))
    }
}
