//
//  RestaurantRow.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 17/11/2025.
//

import SwiftUI

struct RestaurantRow: View {
    
    let restaurant:Restaurant
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://www.slurrp.com/web/_next/image?url=https%3A%2F%2Fimages.slurrp.com%2Fprodarticles%2Fwju1drkd4k.webp%3Fimpolicy%3Dslurrp-20210601%26width%3D1200%26height%3D900%26q%3D75&w=3840&q=75")){
                image in
                
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder:{
                Color.gray
            }
            .frame(width: 60, height: 60)
                        .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4){
                Text(restaurant.restaurantName ?? "Name")
            }
        }
    }
}

#Preview {
   // RestaurantRow(restaurant: Restaurant())
}
