//
//  FilterView.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 24/11/2025.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: RestaurantsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Facilities")) {
                    Toggle("Parking Available", isOn: $viewModel.showParkingOnly)
                }
                
                Section(header: Text("Cuisine Type")) {
                    Picker("Cuisine", selection: $viewModel.selectedCuisine) {
                        Text("All Cuisines").tag("All")
                        ForEach(viewModel.availableCuisines, id: \.self) { cuisine in
                            Text(cuisine).tag(cuisine)
                        }
                    }
                }
                
                Section(header: Text("Sort By")) {
                    Picker("Sort By", selection: $viewModel.selectedSort) {
                        ForEach(RestaurantsViewModel.SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Button("Apply Filters") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Reset All", role: .destructive) {
                        resetFilters()
                    }
                }
            }
            .navigationTitle("Filters & Sort")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func resetFilters() {
        viewModel.selectedCuisine = "All"
        viewModel.selectedSort = .name
        viewModel.showParkingOnly = false
    }
}
