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
    case isLoading
    case error(message: String)
    case loaded(favProducts: [ProductModel])
    case favsEmpty
}

@Observable
final class FavoritesViewModel: FavoritesProtocol {
    
    var state: FavoriteState = .idle {
        didSet {
        }
    }
    var serviceAPI: ProductAPIServiceProtocol
    var serviceFavorites: StorePersistenceProtocol
    var favorites: [Favorite] = []
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceFavorites = serviceFavorites
    }
    
    func getFavoriteProducts() async {
        do {
            let productIds = favorites.map { $0.productID }
            let favoriteProducts = try await serviceAPI.getFiltredProducts(by: productIds)
            state = .loaded(favProducts: favoriteProducts)
        } catch {
            state = .error(message: "failed to load favorite products")
        }
    }
    
    func getFavorites() {
        _ = try? serviceFavorites.getFavorites()
    }
    
    func toggleFavorite(_ id: Int)  {
        serviceFavorites.toggleFavorite(id)
    }
    
    func loadingFavorites() async {
         
        state = .isLoading
        
        do {
            favorites = try serviceFavorites.getFavorites()
            
            if favorites.isEmpty {
                
                state = .favsEmpty
            }
            
            
        } catch {
            
            state = .error(message: "Error to fetch products: \(error.localizedDescription)")
            
        }
    }
}



