//
//  RestaurantsSwiftUIApp.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 04/11/2025.
//

import SwiftUI

@main
struct RestaurantsSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            RestaurantsListView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
