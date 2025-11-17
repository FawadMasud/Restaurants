//
//  RestaurantsViewModel.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 17/11/2025.
//

import Foundation
import CoreData

@MainActor
class RestaurantsViewModel:ObservableObject {
    
    @Published var restaurants:[Restaurant] = []
    @Published var isLoading = false
    @Published var errorMessage:String?
    
    private let apiService = RestaurantsAPISerivce()
    private let coreDataManager = CoreDataManager()
    
    func loadRestaurants() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            let apiRestaurants = try await apiService.getAllRestaurants()
        }
        catch {
            errorMessage = error.localizedDescription
        }
        
        
    }
    
    
    private func saveRestaurantsToCoreData(_apiRestaurants:[RestaurantAPI]) {
        
        let context = coreDataManager.viewContext
        
        context.perform {
            
            for _apiRestaurant in _apiRestaurants {
                
                let fetchRequest:NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "restaurantID == %@", _apiRestaurant.restaurantID)
                
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
    
}
