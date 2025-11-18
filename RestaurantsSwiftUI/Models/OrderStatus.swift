//
//  OrderStatus.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

enum OrderStatus: String, CaseIterable {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case preparing = "Preparing"
    case onTheWay = "On the Way"
    case delivered = "Delivered"
    case cancelled = "Cancelled"
}
