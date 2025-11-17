//
//  RestaurantsListView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 17/11/2025.
//

import SwiftUI

struct RestaurantsListView: View {

    @StateObject private var viewModel = RestaurantsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Restaurants")
                }
                else if let error = viewModel.errorMessage {
                    ErrorView(error: error, retryAction: {
                        Task{
                            await viewModel.loadRestaurants()
                        }
                    })
                }
                else
                {
                    List(viewModel.restaurants) {
                        
                        restaurant in
                        
//                        NavigationLink(destination: nil ){
//                            RestaurantRow(restaurant: restaurant)
//                        }
                        
                        RestaurantRow(restaurant: restaurant)
                    }
                }
            }
        }
        .navigationTitle("Restaurants")
        .refreshable {
            await viewModel.loadRestaurants()
        }
        .task {
            await viewModel.loadRestaurants()
        }
    }
}

#Preview {
    RestaurantsListView()
}
