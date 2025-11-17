//
//  ErrorView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 17/11/2025.
//

import SwiftUI

struct ErrorView: View {
    
    let error: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing:16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.orange)
            
            Text(error)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button("Retry",action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    let retryAction: () -> Void = {
            print("Retry tapped in preview")
        }
    
    ErrorView(error: "", retryAction: retryAction)
}
