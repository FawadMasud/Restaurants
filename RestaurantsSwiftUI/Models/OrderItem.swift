//
//  OrderItem.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

struct OrderItem: Codable {
    let menuItemID: Int16
    let name: String
    var quantity: Int
    let price: Double
}
