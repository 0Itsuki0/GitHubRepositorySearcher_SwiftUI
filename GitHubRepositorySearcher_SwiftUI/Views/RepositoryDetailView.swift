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
               
               Spacer()
               Divider()

               Description
                 .padding(.vertical)
                 .padding(.top, 35)
                 .padding(.horizontal)
               
               MoreInformations
                   .padding(.horizontal)
                   .padding(.bottom, 35)
               
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
            viewModel.avatarImage
                .scaledToFit()
                .padding(.all, 40)
            Spacer()
            Text("\(viewModel.repository.fullName)")
        }
        .foregroundColor(.white)
        .font(.system(size: 25))
    }
    
    
    var Description: some View {
        Text("\(viewModel.repository.description ?? "No Description available")")
            .font(.system(size: 15))
            .multilineTextAlignment(.leading)
            .foregroundColor(.white)
        }
    
    
    var MoreInformations: some View {
        HStack {
            VStack {
                Text("stargazers_count")
                    .font(.system(size: 20))
                    .padding(.bottom, 10)
                Text("\(viewModel.repository.stargazersCount ?? 0)")
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("forks")
                    .font(.system(size: 20))
                    .padding(.bottom, 10)
                Text("\(viewModel.repository.forks ?? 0)")
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("open_issues")
                    .font(.system(size: 20))
                    .padding(.bottom, 10)
                Text("\(viewModel.repository.openIssues ?? 0)")
                    .font(.subheadline)
                
            }
            
            Spacer()
            VStack {
                Text("watchers_count")
                    .font(.system(size: 20))
                    .padding(.bottom, 10)
                Text("\(viewModel.repository.watchersCount ?? 0)")
                    .font(.subheadline)
                
            }
        }
        .foregroundColor(.black)
        .font(.system(size: 25))
    }
    
}
