//
//  ContentView.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/03.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel = RepositoryListViewModel()
    
    var body: some View {
           NavigationView {
               ZStack {
                   // Background color. LinearGradient in this case.
                   Background
                       .ignoresSafeArea()
                   
                   VStack {
                       // Textfield including text above it
                       SearchField
                       
                       // List of weather of the cities.
                       RepositoryList
                   }
               }
               .navigationBarHidden(true)
           }
       }
}

extension RepositoryListView {
    
    var Background: some View {
        LinearGradient(colors: [Color(red: 71/255, green: 110/255, blue: 168/255),
                                Color(red: 6/255, green: 9/255, blue: 28/255)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        
    }
    
    var SearchField: some View {
        VStack {
            Text("Search for GitHub Repository")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(.top)
                .padding(.vertical, 10)
            
            
            HStack {
                TextField("e.g Swift ", text: $viewModel.searchFieldText)
                    .padding()
                    .foregroundColor(.white)
                    .background(.white.opacity(0.17))
                    .cornerRadius(10)
                    .frame(width: 300, height: 50, alignment: .center)
                    .shadow(color: .black, radius: 5, x: 0, y: 2)
                
                Spacer()
                Button(action: {viewModel.fetchRepositoryList()}) {
                    Image(systemName: "paperplane")
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.white)
                }
                
            }
            .padding(.all, 10)
            .padding(.bottom, 20)
        }
        
    }
    
    
    
    var RepositoryList: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.results, id: \.id) { result in
                    let repository = RepositoryDetailViewModel(repository: result)
                    NavigationLink(destination: RepositoryDetailView(viewModel: repository)) {
                        RepositoryListCellView(viewModel: repository)
                    }
                    Divider()
                        .background(.white)
                }
            }

        }
    }
 
    
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
