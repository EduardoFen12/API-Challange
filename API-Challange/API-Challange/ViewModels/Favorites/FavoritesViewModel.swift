//
//  FavoritesViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 16/08/25.
//

import SwiftUI
import Observation
import SwiftData

/// Represents the possible states of the favorites view.
enum FavoriteState {
    /// The initial state.
    case idle
    /// The state while favorite products are being loaded.
    case isLoading
    /// The state when an error occurs during loading.
    case error(message: String)
    /// The state when favorite products have been successfully loaded.
    case loaded(favProducts: [ProductModel])
    /// The state when the list of favorites is empty.
    case favsEmpty
}

/// The view model responsible for managing the favorite products' data and business logic.
@Observable
final class FavoritesViewModel: FavoritesProtocol {
    
    /// The current state of the favorites view.
    var state: FavoriteState = .idle
    /// The service for fetching product data from the API.
    var serviceAPI: ProductAPIServiceProtocol
    /// The service for persisting favorite product data locally.
    var serviceFavorites: StorePersistenceProtocol
    /// The list of favorite items fetched from the local store.
    var favorites: [Favorite] = []
    
    /// Initializes the view model with API and storage services.
    /// - Parameters:
    ///   - serviceAPI: The API service to fetch product details.
    ///   - serviceFavorites: The persistence service to manage favorite data.
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceFavorites = serviceFavorites
    }
    
    /// Fetches the detailed product information for the current list of favorite IDs.
    @MainActor
    func getFavoriteProducts() async {
        do {
            let productIds = favorites.map { $0.productID }
            // Avoids an API call if there are no favorite IDs.
            guard !productIds.isEmpty else {
                state = .favsEmpty
                return
            }
            let favoriteProducts = try await serviceAPI.getFiltredProducts(by: productIds)
            state = .loaded(favProducts: favoriteProducts)
        } catch {
            state = .error(message: "Failed to load favorite products.")
        }
    }
    
    /// Fetches the list of favorite IDs from the local persistence service.
    /// This method is intended to update the internal `favorites` array but does not change the state.
    func getFavorites() {
        // The result is intentionally ignored as the main update is handled by `loadingFavorites`.
        _ = try? serviceFavorites.getFavorites()
    }
    
    /// Toggles the favorite status for a given product ID.
    /// - Parameter id: The unique identifier of the product.
    func toggleFavorite(_ id: Int)  {
        serviceFavorites.toggleFavorite(id)
    }
    
    /// Loads the initial list of favorite IDs from the persistence layer and updates the state.
    @MainActor
    func loadingFavorites() async {
         
        state = .isLoading
        
        do {
            favorites = try serviceFavorites.getFavorites()
            
            if favorites.isEmpty {
                
                state = .favsEmpty
            }
            // After loading IDs, the next step is typically to call `getFavoriteProducts`.
            
        } catch {
            
            state = .error(message: "Error to fetch products: \(error.localizedDescription)")
            
        }
    }
}



