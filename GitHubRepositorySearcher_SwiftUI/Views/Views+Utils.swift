//
//  Views+Alerts.swift
//  GitHubRepositorySearcher_SwiftUI
//
//  Created by イツキ on 2023/03/04.
//

import Foundation
import SwiftUI

extension View {
    
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "Dismiss") -> some View {
        let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "")
        }
    }
    
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }

}
