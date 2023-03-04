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
                Text("\(viewModel.repository.fullName)")
                    .bold()
                    .font(.system(size:25))
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(viewModel.repository.description ?? "")
                    .font(.system(size:15))
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 10)


            Spacer()
            
            Text("\(viewModel.repository.language ?? "")")
                .padding(.trailing, 10)
                .font(.system(size: 20))
        }
        .foregroundColor(.white)
    }
        
    init(viewModel: RepositoryDetailViewModel) {
        self.viewModel = viewModel
    }
}

