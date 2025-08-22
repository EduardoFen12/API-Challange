//
//  CartViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation
import SwiftData

enum CartState {
    case idle
    case isLoading
    case error(message: String)
    case loaded
    case cartEmpty
}
 



@Observable
final class CartViewModel: CartViewModelProtocol {
    var state: CartState = .idle
    var serviceAPI: ProductAPIServiceProtocol
    var serviceStore: StorePersistenceProtocol
    var cartDisplayItems: [CartDisplayItem] = []
    
    var totalPrice: String {
        let total = cartDisplayItems.reduce(0) { partialResult, item in
            let itemSubtotal = item.product.price * Double(item.cartItem.quantity)
            return partialResult + itemSubtotal
        }
        return NumberFormatterManager.shared.doubleToString(total)
    }
    
    func saveToOrders() async {
        
        cartDisplayItems.forEach { item in
            
            for _ in 1...item.cartItem.quantity {
                serviceStore.saveToOrders(item.product.title, price: item.product.price, image: item.product.thumbnail)
            }
        }
        
        for item in cartDisplayItems {
            serviceStore.removeFromCart(item.id)
        }
        
        await loadCart()
        
    }
    

    init(serviceAPI: ProductAPIServiceProtocol, serviceStore: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceStore = serviceStore
    }
    
    @MainActor
    func loadCart() async {
        state = .isLoading
        
        do {
            //aqui talvez
            let cartItemsFromDB = try serviceStore.getAllCart()
            
            if cartItemsFromDB.isEmpty {
                state = .cartEmpty
                self.cartDisplayItems = [] // Clear the list for the UI (ISSO QUE FALTAVA)
                return
            }
            
            // 2. Get product IDs for the API call
            let productIds = cartItemsFromDB.map { $0.productID }
            
            // 3. Fetch product details from the API (1 API call)
            let productsFromAPI = try await serviceAPI.getFiltredProducts(by: productIds)
            
            // 4. Combine the results into the list that the View will use
            self.cartDisplayItems = productsFromAPI.compactMap { product in
                if let cartItem = cartItemsFromDB.first(where: { $0.productID == product.id }) {
                    return CartDisplayItem(product: product, cartItem: cartItem)
                }
                return nil
            }
            
            state = .loaded
            
        } catch {
            state = .error(message: "Failed to load the cart: \(error.localizedDescription)")
        }
    }
    

    func increaseQuantity(for item: CartDisplayItem) {
        serviceStore.addToQuantity(item.id)

        Task { await self.loadCart() }
    }

    func decreaseQuantity(for item: CartDisplayItem) {
        serviceStore.removeFromQuantity(item.id)
        Task { await self.loadCart() }
    }
    
    /// Completely removes an item from the cart.
    /// - Parameter item: The `CartDisplayItem` to remove.
    func removeItem(for item: CartDisplayItem) {
        serviceStore.removeFromCart(item.id)
        Task { await self.loadCart() }
    }
}
