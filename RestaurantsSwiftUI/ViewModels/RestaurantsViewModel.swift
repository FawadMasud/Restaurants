//
//  RestaurantsViewModel.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 17/11/2025.
//

import Foundation
import CoreData
import Combine

@MainActor
class RestaurantsViewModel:ObservableObject {
    
    @Published var restaurants:[Restaurant] = []
    @Published var filteredRestaurants: [Restaurant] = []
    @Published var isLoading = false
    @Published var errorMessage:String?
    @Published var searchText = ""
    @Published var selectedCuisine = "All"
    @Published var selectedSort: SortOption = .name
    @Published var showParkingOnly = false
    
    private let apiService = RestaurantsAPISerivce()
    private let coreDataManager = CoreDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption: String, CaseIterable {
            case name = "Name A-Z"
            case type = "Cuisine"
    }
    
    var availableCuisines: [String] {
        let allTypes = restaurants.compactMap { $0.type }
            return Array(Set(allTypes)).sorted()
        }
    
    init() {
            loadRestaurantsFromCoreData()
            setupFiltering()
        }
    
    func loadRestaurants() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            let apiRestaurants = try await apiService.getAllRestaurants()
            
            await saveRestaurantsToCoreData(_apiRestaurants: apiRestaurants)
            
            loadRestaurantsFromCoreData()
        }
        catch {
            errorMessage = error.localizedDescription
            
            loadRestaurantsFromCoreData()
        }
        
        isLoading = false
        
        
    }
    
    
    private func saveRestaurantsToCoreData(_apiRestaurants:[RestaurantAPI]) async {
        
        let context = coreDataManager.viewContext
        
        await context.perform {
            
            for _apiRestaurant in _apiRestaurants {
                
                let fetchRequest:NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "restaurantID == %d", _apiRestaurant.restaurantID)
                
                let restaurant:Restaurant
                
                if let existingRestaurant = try? context.fetch(fetchRequest).first {
                    
                    restaurant = existingRestaurant
                }
                else
                {
                    restaurant = Restaurant(context: context)
                    restaurant.restaurantID = _apiRestaurant.restaurantID
                }
                
                restaurant.restaurantName = _apiRestaurant.restaurantName
                restaurant.parkingLot = _apiRestaurant.parkingLot
                restaurant.address = _apiRestaurant.address
                restaurant.type = _apiRestaurant.type
                
                try? context.save()
            }
        }
        
    }
    
    private func loadRestaurantsFromCoreData(){
        
        let context = coreDataManager.viewContext
        let fetchResquest:NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        
        fetchResquest.sortDescriptors = [NSSortDescriptor(keyPath: \Restaurant.restaurantName, ascending: true)]
        
        do {
            restaurants = try context.fetch(fetchResquest)
        }
        catch
        {
            //errorMessage = error.localizedDescription
            errorMessage = "Failed to load restaurants from local storage"
        }
    }
    
    private func setupFiltering() {
            Publishers.CombineLatest4($searchText, $selectedCuisine, $selectedSort, $showParkingOnly)
                .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
                .sink { [weak self] _ in
                    self?.filterAndSortRestaurants()
                }
                .store(in: &cancellables)
        }
        
        private func filterAndSortRestaurants() {
            var filtered = restaurants
            
            // Apply search filter
            if !searchText.isEmpty {
                filtered = filtered.filter {
                    $0.restaurantName?.localizedCaseInsensitiveContains(searchText) == true ||
                    $0.type?.localizedCaseInsensitiveContains(searchText) == true
                }
            }
            
            // Apply cuisine filter
            if selectedCuisine != "All" {
                filtered = filtered.filter {
                    $0.type == selectedCuisine
                }
            }
            
            // Apply parking filter
            if showParkingOnly {
                filtered = filtered.filter { $0.parkingLot }
            }
            
            // Apply sorting
//            filtered.sort { r1, r2 in
//                switch selectedSort {
//                case .name:
//                    return (r1.name ?? "") < (r2.name ?? "")
//                case .type:
//                    return (r1.type ?? "") < (r2.type ?? "")
//                }
//            }
            
            filteredRestaurants = filtered
        }
        
        func refresh() async {
            await loadRestaurants()
        }
    
}
