//
//  Loader.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/04.
//

import Foundation
import SwiftUI

struct Loader: View {
    
    @Binding var isShown: Bool
    
    var body: some View {
        VStack {
            
            ProgressView() {
                Text("Please wait...")
                    .font(.headline)
                    .padding(.top, 15)
            }
            .padding(.all, 50)
            .background(RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 25.0)
                    .stroke(.secondary, style: StrokeStyle()))
            )
            .progressViewStyle(CircularProgressViewStyle(tint: .secondary))
            .padding()            
        }
        .padding(.all, 20)
        .isHidden(!isShown)
        
    }
    
}
    
struct Loader_Previews: PreviewProvider {
    @State static var isShown = true
    static var previews: some View {
        Loader(isShown: $isShown)
    }
}
    
