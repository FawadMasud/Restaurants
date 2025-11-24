//
//  EmptyStateView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 24/11/2025.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "fork.knife.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No restaurants found")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Try adjusting your filters or search terms")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView()
}
