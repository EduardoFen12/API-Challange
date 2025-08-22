//
//  HomeViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI
import Observation

/// Represents the possible states of the Home view.
enum HomeState {
    /// The initial state, before any loading has begun.
    case idle
    /// The state while products are being loaded from the API.
    case loading
    /// The state when an error has occurred during loading.
    case error
    /// The state when the products have been successfully loaded.
    case loaded
}

/// The view model responsible for managing the Home screen's data and business logic.
@Observable
final class HomeViewModel: HomeProtocol {
    
    /// The current state of the Home view.
    var state: HomeState = .idle
    /// The service for fetching product data from the API.
    let serviceAPI: ProductAPIServiceProtocol
    /// The service for persisting favorite product data locally.
    var storeFavorites: StorePersistenceProtocol
    
    /// The product featured as the "deal of the day".
    var dealOfDay: ProductModel
    /// The list of products to be displayed in the "top picks" section.
    var products: [ProductModel]
    /// A string containing the description of an error, if one occurs.
    var errorMessage: String
    /// A list of the user's favorite items, used to determine the favorite status of products.
    var favorites: [Favorite] = []
    
    /// Initializes the view model with API and storage services.
    /// - Parameters:
    ///   - serviceAPI: The API service to fetch product details.
    ///   - storeFavorites: The persistence service to manage favorite data.
    init(serviceAPI: ProductAPIServiceProtocol, storeFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.storeFavorites = storeFavorites
        
        // Initializes properties with default empty values.
        self.dealOfDay = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")
        self.products = []
        self.errorMessage = ""
    }
    
    /// Toggles the favorite status for a given product ID and refreshes the local favorites list.
    /// - Parameter id: The unique identifier of the product.
    func toggleFavorite(_ id: Int) {
        storeFavorites.toggleFavorite(id)
        getFavorites()
    }
    
    /// Fetches the list of favorite IDs from the local persistence service.
    func getFavorites() {
        do {
            favorites = try storeFavorites.getFavorites()
        } catch {
            print("Error fetching favorites: \(error.localizedDescription)")
        }
    }
    
    /// Checks if a product is marked as a favorite.
    /// - Parameter id: The unique identifier of the product.
    /// - Returns: `true` if the product is a favorite, otherwise `false`.
    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(where: { $0.productID == id })
    }
    
    /// Loads all necessary products for the Home view from the API.
    /// This includes the "deal of the day" and the main product list.
    @MainActor
    func loadProducts() async {
        state = .loading
        getFavorites() // Load favorites initially to show correct heart icons.
        
        do {
            // Fetches the deal of the day and all other products in parallel.
            async let deal = serviceAPI.getRandomProduct()
            async let allProducts = serviceAPI.getAllProducts()
            
            self.dealOfDay = try await deal
            self.products = try await allProducts
            
            state = .loaded
        } catch {
            errorMessage = "Error fetching products: \(error.localizedDescription)"
            state = .error
        }
    }
}


