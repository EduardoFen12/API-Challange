//
//  CartViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation
import SwiftData

/// Represents the possible states of the cart view.
enum CartState {
    /// The initial state.
    case idle
    /// The state while cart items are being loaded.
    case isLoading
    /// The state when an error occurs.
    case error(message: String)
    /// The state when the cart items have been successfully loaded.
    case loaded
    /// The state when the cart is empty.
    case cartEmpty
}

/// A display item that combines a product with its corresponding cart information.
struct CartDisplayItem: Identifiable, Equatable {
    /// The product details.
    let product: ProductModel
    /// The cart item details (e.g., quantity).
    let cartItem: Cart
    
    /// The unique identifier for the display item, based on the product's ID.
    var id: Int { product.id }
    
    /// Checks for equality between two `CartDisplayItem` instances based on their ID.
    static func == (lhs: CartDisplayItem, rhs: CartDisplayItem) -> Bool {

        lhs.id == rhs.id
    }
}

/// The view model responsible for managing the shopping cart's data and business logic.
@Observable
final class CartViewModel: CartViewModelProtocol {
    /// The current state of the cart view.
    var state: CartState = .idle
    /// The service for fetching product data from the API.
    var serviceAPI: ProductAPIServiceProtocol
    /// The service for persisting cart data locally.
    var serviceStore: StorePersistenceProtocol
    
    /// The list of items to be displayed in the cart view.
    var cartDisplayItems: [CartDisplayItem] = []
    
    /// The formatted total price of all items in the cart.
    var totalPrice: String {
        let total = cartDisplayItems.reduce(0) { partialResult, item in
            let itemSubtotal = item.product.price * Double(item.cartItem.quantity)
            return partialResult + itemSubtotal
        }
        return NumberFormatterManager.shared.doubleToString(total)
    }
    
    /// Initializes the view model with API and storage services.
    /// - Parameters:
    ///   - serviceAPI: The API service to fetch product details.
    ///   - serviceStore: The persistence service to manage cart data.
    init(serviceAPI: ProductAPIServiceProtocol, serviceStore: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceStore = serviceStore
    }
    
    /// Loads the cart items by fetching data from the local database and the remote API.
    @MainActor
    func loadCart() async {
        state = .isLoading
        
        do {
            // 1. Get cart items from the database (1 DB query)
            let cartItemsFromDB = try serviceStore.getAllCart()
            
            if cartItemsFromDB.isEmpty {
                state = .cartEmpty
                self.cartDisplayItems = [] // Clear the list for the UI
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
    
    /// Increases the quantity of a specific item in the cart.
    /// - Parameter item: The `CartDisplayItem` to increase the quantity of.
    func increaseQuantity(for item: CartDisplayItem) {
        serviceStore.addToQuantity(item.id)
        // Reloads the data to reflect the change in total price and quantity.
        Task { await self.loadCart() }
    }
    
    /// Decreases the quantity of a specific item in the cart.
    /// - Parameter item: The `CartDisplayItem` to decrease the quantity of.
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
