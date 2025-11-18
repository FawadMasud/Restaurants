//
//  CartView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: RestaurantDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showingOrderConfirmation = false
    @State private var orderSuccess = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.cart.isEmpty {
                    EmptyCartView()
                } else {
                    List {
//                        ForEach(viewModel.cart, id: \.menuItemId) { item in
//                            CartItemRow(item: item) { quantity in
//                                viewModel.updateQuantity(for: item, quantity: quantity)
//                            } onRemove: {
//                                viewModel.removeFromCart(item: item)
//                            }
//                        }
                        
//                        Section {
//                            HStack {
//                                Text("Total")
//                                    .font(.headline)
//                                Spacer()
//                                Text("$\(viewModel.totalAmount, specifier: "%.2f")")
//                                    .font(.headline)
//                                    .foregroundColor(.green)
//                            }
//                        }
                    }
                    
                    VStack(spacing: 16) {
                        Button(action: {
//                            Task {
//                                let success = await viewModel.placeOrder()
//                                orderSuccess = success
//                                showingOrderConfirmation = true
//                            }
                        }) {
                            if viewModel.isOrdering {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
//                                Text("Place Order - $\(viewModel.totalAmount, specifier: "%.2f")")
//                                    .font(.headline)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.cart.isEmpty || viewModel.isOrdering)
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                }
            }
            .navigationTitle("Your Cart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .alert("Order Confirmation", isPresented: $showingOrderConfirmation) {
                Button("OK") {
                    if orderSuccess {
                        dismiss()
                    }
                }
            } message: {
                Text(orderSuccess ?
                     "Your order has been placed successfully!" :
                     "Failed to place order. Please try again.")
            }
        }
    }
}



#Preview {
   // CartView()
}
