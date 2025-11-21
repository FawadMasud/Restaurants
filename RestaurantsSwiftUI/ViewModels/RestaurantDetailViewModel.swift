//
//  RestaurantDetailViewModel.swift
//  RestaurantsSwiftUI
//
//  Created by Fawad Masud on 18/11/2025.
//

import Foundation
import CoreData

@MainActor
class RestaurantDetailViewModel: ObservableObject {
    
    @Published var menuItems:[MenuItem]  = []
    @Published var isLoading = false
    @Published var errorMessage:String?
    @Published var cart:[OrderItem] = []
    @Published var isOrdering = false
    
    private let apiService = RestaurantsAPISerivce()
    private let coreDataManager = CoreDataManager.shared
    let restaurant:Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    var totalAmount: Double {
            cart.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        }
    
    func loadMenu() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            let menuItems = try await apiService.getMenu(restaurantId: Int(restaurant.restaurantID))
            await saveMenuItemsToCoreData(_menuItems: menuItems)
            loadMenuItemsFromCoreData()
        }
        catch
        {
            errorMessage = "Failed to load menu: \(error.localizedDescription)"
            loadMenuItemsFromCoreData()
        }
        
        isLoading = false
    }
    
    func saveMenuItemsToCoreData(_menuItems:[MenuItemAPI]) async
    {
        let context = coreDataManager.viewContext
        
        await context.perform {
            
            for _menuItem in _menuItems {
                
                let fetchRequest:NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "itemID == %d", _menuItem.itemID)
                
                let menuItem:MenuItem
                
                if let existingMenuitem = try? context.fetch(fetchRequest).first {
                    
                    menuItem = existingMenuitem
                }
                else
                {
                    menuItem = MenuItem(context: context)
                    menuItem.restaurantID = _menuItem.restaurantID
                }
                
                menuItem.restaurantName = _menuItem.restaurantName
                menuItem.itemDescription = _menuItem.itemDescription
                menuItem.itemPrice = _menuItem.itemPrice
                menuItem.itemID = _menuItem.itemID
                menuItem.imageUrl = _menuItem.imageUrl
                menuItem.itemPrice = _menuItem.itemPrice
                menuItem.restaurantID = _menuItem.restaurantID
                
                try? context.save()
            }
        }
    }
    
    func loadMenuItemsFromCoreData(){
        
        let context = coreDataManager.viewContext
        let fetchRequest:NSFetchRequest<MenuItem> = MenuItem.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "restaurantID == %d", restaurant.restaurantID)
        
        do {
            menuItems = try context.fetch(fetchRequest)
        }
        catch
        {
            //errorMessage = error.localizedDescription
            errorMessage = "Failed to load restaurants from local storage"
        }
        
    }
    
    func addToCart(item:MenuItem)
    {
        if let index = cart.firstIndex(where: {$0.menuItemID == item.itemID})
        {
            cart[index].quantity += 1
        }
        else
        {
            let orderItem = OrderItem(menuItemID: item.itemID,
                                      name: item.itemName ?? "Name",
                                      quantity: 1,
                                      price: item.itemPrice)
            cart.append(orderItem)
            
        }
    }
    
    func removeFromCart(item:OrderItem)
    {
        cart.removeAll(where: {$0.menuItemID == item.menuItemID})
    }
    
    func updateQuantity(item:OrderItem,quantity:Int)
    {
        
    }
    
}
