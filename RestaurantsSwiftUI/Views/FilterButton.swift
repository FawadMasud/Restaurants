//
//  FilterButton.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 24/11/2025.
//

import SwiftUI

struct FilterButton: View {
    @ObservedObject var viewModel: RestaurantsViewModel
    @State private var showingFilters = false
    
    var body: some View {
        Button("Filter") {
            showingFilters = true
        }
        .sheet(isPresented: $showingFilters) {
            FilterView(viewModel: viewModel)
        }
    }
}

#Preview {
   // FilterButton()
}
