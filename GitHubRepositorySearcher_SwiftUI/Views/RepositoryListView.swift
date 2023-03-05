//
//  RepositoryListView.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/03.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel = RepositoryListViewModel()
    @FocusState private var searchFieldFocused: Bool
    
    var body: some View {
           NavigationView {
               ZStack {

                   Background
                       .ignoresSafeArea()
                   
                   VStack {
                       SearchField
                       
                       RepositoryList
                   }
                   .errorAlert(error: $viewModel.error)
                   
                   Loader(isShown: $viewModel.isLoading)
                       .accessibilityIdentifier("loader")
               }
               .navigationBarHidden(true)
               .onTapGesture {
                   searchFieldFocused = false
               }
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
                .padding(.top, 10)
                .padding(.bottom, 5)
            
            HStack {
                ZStack(alignment: .trailing) {
                    TextField("e.g Swift ", text: $viewModel.searchFieldText)
                        .onSubmit { viewModel.fetchRepositoryList() }
                        .focused($searchFieldFocused)
                        .padding()
                        .foregroundColor(.white)
                        .background(.white.opacity(0.17))
                        .cornerRadius(10)
                        .frame(height: 50, alignment: .center)
                        .shadow(color: .black, radius: 5, x: 0, y: 2)
                        .accessibilityIdentifier("searchField")
                    
                    Button(action: { viewModel.searchFieldText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding(.trailing, 10)
                            .foregroundColor(.secondary)
                    }
                    .accessibilityIdentifier("clearButton")
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.fetchRepositoryList()
                    searchFieldFocused = false
                }) {
                    Image(systemName: "paperplane")
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.white)
                }
                .accessibilityIdentifier("searchButton")
                
            }
            .padding(.all, 10)
            .padding(.bottom, 20)
        }
        
    }
    
    
    
    var RepositoryList: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.repositoryList, id: \.id) { result in
                    let repository = RepositoryDetailViewModel(repository: result)
                    NavigationLink(destination: RepositoryDetailView(viewModel: repository)) {
                        RepositoryListCellView(viewModel: repository)
                    }
                    Divider()
                        .background(.white)
                }
            }
        }
        .accessibilityIdentifier("repositoryListView")
    }
 
    
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView()
    }
}
