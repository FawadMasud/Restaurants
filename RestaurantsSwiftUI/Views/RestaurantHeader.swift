//
//  RestaurantHeader.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

import SwiftUI

struct RestaurantHeader: View {
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: "https://www.slurrp.com/web/_next/image?url=https%3A%2F%2Fimages.slurrp.com%2Fprodarticles%2Fwju1drkd4k.webp%3Fimpolicy%3Dslurrp-20210601%26width%3D1200%26height%3D900%26q%3D75&w=3840&q=75")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(height: 200)
            .cornerRadius(12)
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(restaurant.restaurantName ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                
//                Text(restaurant.description)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
                
//                HStack {
//                    ForEach(0..<5) { star in
//                        Image(systemName: star < Int(restaurant.rating) ? "star.fill" : "star")
//                            .foregroundColor(.yellow)
//                    }
//                    
//                    Text(String(format: "%.1f", restaurant.rating))
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                }
                
                Text(restaurant.address ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
//                Text(restaurant.description)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
   // RestaurantHeader()
}
