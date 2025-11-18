//
//  MenuItemRow.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

import SwiftUI

struct MenuItemRow: View {
    let item: MenuItem
    let onAddToCart: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.itemName ?? "")
                    .font(.headline)
                
                Text(item.itemDescription ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                Text("$\(item.itemPrice, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            Button("Add") {
                onAddToCart()
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
  //  MenuItemRow()
}
