//
//  FavoritesViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 16/08/25.
//

import SwiftUI
import Observation
import SwiftData

enum FavoriteState {
    case idle
    case error(message: String)
    case loaded
    case favsEmpty
}


@Observable
final class FavoritesViewModel: FavoritesProtocol {
    

    var state: FavoriteState = .idle
    var serviceAPI: ProductAPIServiceProtocol
    var storeFavorites: StorePersistenceProtocol
    var favorites: [Favorite] = []
    var favProducts: [ProductModel] = []
    
    init(serviceAPI: ProductAPIServiceProtocol, storeFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.storeFavorites = storeFavorites
        
    }
    
    @MainActor
    func getFavoriteProducts() async {
        do {
            let productIds = favorites.map { $0.productID }

            guard !productIds.isEmpty else {
                state = .favsEmpty
                return
            }
            
            favProducts = try await serviceAPI.getFiltredProducts(by: productIds)
            state = .loaded
        } catch {
            state = .error(message: "Failed to load favorite products.")
        }
    }
    
    func getFavorites() {
        do {
            favorites = try storeFavorites.getFavorites()
        } catch {
            print("Error fetching favorites: \(error.localizedDescription)")
        }
    }
    

    func toggleFavorite(_ id: Int) {
        storeFavorites.toggleFavorite(id)
        getFavorites()
    }
    
    @MainActor
    func loadingFavorites() async {

        do {
            favorites = try storeFavorites.getFavorites()
            
            if favorites.isEmpty {
                
                state = .favsEmpty
            }

            
        } catch {
            
            state = .error(message: "Error to fetch products: \(error.localizedDescription)")
            
        }
    }
    
    func search(by name: String) {
        if !name.isEmpty {
            favProducts = favProducts.filter {$0.title.localizedCaseInsensitiveContains(name)}
        }
    }
}



