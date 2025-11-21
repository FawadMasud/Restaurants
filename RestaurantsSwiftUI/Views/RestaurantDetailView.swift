//
//  RestaurantDetailView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 17/11/2025.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    let restaurant:Restaurant
    @StateObject private var viewModel: RestaurantDetailViewModel
    @State var showCart = false
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        _viewModel = StateObject(wrappedValue: RestaurantDetailViewModel(restaurant: restaurant))
    }
    
    var body: some View {
        VStack {
            
            if viewModel.isLoading {
                ProgressView("Loading Menu...")
            } else if let error = viewModel.errorMessage {
                ErrorView(error: error, retryAction: {
                    Task{
                        await viewModel.loadMenu()
                    }
                })
            }
            else
            {
                List{
                    RestaurantHeader(restaurant: restaurant)
                    
                    ForEach(viewModel.menuItems)
                    { item in
                        MenuItemRow(item: item){
                            viewModel.addToCart(item: item)
                        }
                    }
                }
            }
        }
        .navigationTitle(restaurant.restaurantName ?? "")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        CartButton(itemCount: viewModel.cart.count) {
                            showCart = true
                        }
                    }
                }
                .sheet(isPresented: $showCart) {
                    CartView(viewModel: viewModel)
                }
                .task {
                    await viewModel.loadMenu()
                }
    }
    
    
    
}

#Preview {
 //   RestaurantDetailView()
}
