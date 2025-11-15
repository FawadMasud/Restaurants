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
        
        if let url = URL(string: urlString)
        {
            return url
        }
        else
        {
            return nil
        }
    }
    
    func getAllRestaurants() async throws -> [Restaurant] {
        
        
        guard let url = prepareUrl(method: RESTAURANT) else
        {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 .self else {
                  throw URLError(.badServerResponse)
              }
        
        return try JSONDecoder().decode([Restaurant].self, from: data)
        
        
    }
    
    
    
}
