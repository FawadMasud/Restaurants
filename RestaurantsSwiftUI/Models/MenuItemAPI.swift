//
//  MenuItemAPI.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

struct MenuItemAPI: Codable {
    
    let itemID:Int16
    let itemName:String
    let itemDescription:String
    let itemPrice:Double
    let restaurantName:String
    let restaurantID: Int16
    let imageUrl:String
}
