//
//  ProfileView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 24/11/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Environment(\.dismiss) private var dismiss
    @State private var showingOrderHistory = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("User")
                                    .font(.title2)
                                Text("Email")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                }
                
                Section {
                    Button("Order History") {
                        showingOrderHistory = true
                    }
                    
                    Button("Payment Methods") {
                        // Navigate to payment methods
                    }
                    
                    Button("Addresses") {
                        // Navigate to addresses
                    }
                }
                
                Section {
                    Button("Logout", role: .destructive) {
                       // coreDataManager.logout()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingOrderHistory) {
             //   OrderHistoryView()
            }
        }
    }
}

#Preview {
    ProfileView()
}
