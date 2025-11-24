//
//  UserProfileButton.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 24/11/2025.
//

import SwiftUI

struct UserProfileButton: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @State private var showingProfile = false
    
    var body: some View {
        Button {
            showingProfile = true
        } label: {
            Image(systemName: "person.circle.fill")
                .font(.title2)
        }
        .sheet(isPresented: $showingProfile) {
            ProfileView()
        }
    }
}

#Preview {
    UserProfileButton()
}
