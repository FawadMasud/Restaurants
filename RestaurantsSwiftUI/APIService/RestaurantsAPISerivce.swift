//
//  RestaurantsAPISerivce.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 14/11/2025.
//

import Foundation



class RestaurantsAPISerivce: ObservableObject {
    
    private let baseUrl = "https://fakerestaurantapi.runasp.net/api/"
    
    private var headers:[String:String] {
        ["":""]
    }
    
    func prepareUrl(method:String) -> URL? {
        
        let urlString = baseUrl + method
        
        var apiKey:String
        
        let env = EnvironmentManager.shared.current
        
        // Separating development and production
        switch env {
        case .production:
            apiKey = Keys.GoogleApiKeyProd // Keys file added to gitignore
        case .debug:
            apiKey = Keys.GoogleApiKeySandbox
        default:
            apiKey = Keys.GoogleApiKeySandbox
        }
                
        print(apiKey)
        
        if let url = URL(string: urlString)
        {
            return url
        }
        else
        {
            return nil
        }
    }
    
    func getAllRestaurants() async throws -> [RestaurantAPI] {
        
        
        guard let url = prepareUrl(method: RESTAURANT) else
        {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 .self else {
                  throw URLError(.badServerResponse)
              }
        
        return try JSONDecoder().decode([RestaurantAPI].self, from: data)
        
        
    }
    
    func getMenu(restaurantId:Int) async throws -> [MenuItemAPI] {
        
        guard let url = URL(string: "\(baseUrl)Restaurant/\(restaurantId)/Menu") else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url:url)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 .self else {
                  throw URLError(.badServerResponse)
              }
        
        return try JSONDecoder().decode([MenuItemAPI].self, from: data)
    }
    
    
    
}
