//
//  EnvironmentManager.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 17/11/2025.
//

enum Env: String {
    case development
    case debug
    case production
    
    var baseURL: String {
        switch self {
        case .development, .debug:
            return "https://api-dev.example.com"
        case .production:
            return "https://api.example.com"
        }
    }
    
    var appName: String {
        switch self {
        case .development:
            return "MyApp-Dev"
        case .debug:
            return "MyApp-Debug"
        case .production:
            return "MyApp"
        }
    }
    
    var enableLogging: Bool {
        switch self {
        case .development, .debug:
            return true
        case .production:
            return false
        }
    }
    
    var analyticsEnabled: Bool {
        switch self {
        case .development, .debug:
            return false
        case .production:
            return true
        }
    }
}

class EnvironmentManager {
    static let shared = EnvironmentManager()
    
    var current: Env {
        #if DEBUG
        return .debug
        #elseif DEVELOPMENT
        return .development
        #else
        return .production
        #endif
    }
    
    private init() {}
}
