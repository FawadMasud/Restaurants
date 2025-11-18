//
//  SwiftUIView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

import SwiftUI

struct CartItemRow: View {
    let item: OrderItem
    let onQuantityChange: (Int) -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                
                Text("$\(item.price, specifier: "%.2f") each")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Total: $\(item.price * Double(item.quantity), specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            HStack {
                Button("-") {
                    onQuantityChange(item.quantity - 1)
                }
                .buttonStyle(.bordered)
                .disabled(item.quantity <= 1)
                
                Text("\(item.quantity)")
                    .fontWeight(.semibold)
                    .frame(minWidth: 30)
                
                Button("+") {
                    onQuantityChange(item.quantity + 1)
                }
                .buttonStyle(.bordered)
            }
            
            Button(role: .destructive) {
                onRemove()
            } label: {
                Image(systemName: "trash")
            }
            .buttonStyle(.bordered)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
  //  SwiftUIView()
}
