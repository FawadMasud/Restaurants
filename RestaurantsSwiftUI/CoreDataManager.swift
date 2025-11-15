//
//  CoreDataManager.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 04/11/2025.
//

import CoreData
import Foundation

class CoreDataManager:ObservableObject {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    init() {
        
        container = NSPersistentContainer(name: "RestaurantsSwiftUI")
        
        container.loadPersistentStores { description,error in
            
            if let error = error {
                
                print("Core Data failed to load: \(error.localizedDescription)")
            }
                
        }
    }
    
    var viewContext:NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext(){
        do{
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
