//
//  CartButton.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

import SwiftUI

struct CartButton: View {
    let itemCount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .font(.title2)
                
                if itemCount > 0 {
                    Text("\(itemCount)")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 8, y: -8)
                }
            }
        }
    }
}

#Preview {
  //  CartButton()
}
