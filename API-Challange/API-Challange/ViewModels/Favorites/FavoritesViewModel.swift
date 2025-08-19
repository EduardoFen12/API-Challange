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
    case loaded
    case favsEmpty
}

@Observable
final class FavoritesViewModel: FavoritesProtocol {
    
    var state: FavoriteState = .idle {
        didSet {
            print("newState: \(state)")
        }
    }
    var serviceAPI: ProductAPIServiceProtocol
    var favorites: [Favorite] = []
    var favoriteProducts: [ProductModel] = []
    let serviceFavorites: ProductFavoriteProtocol
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: ProductFavoriteProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceFavorites = serviceFavorites
    }
    
    func getFavoriteProducts() async {
        do {
            let productIds = favorites.map { $0.productID }
            favoriteProducts = try await serviceAPI.getProduct(by: productIds)
            favoriteProducts.forEach{print($0.id)}
            state = .loaded
        } catch {
            state = .error(message: "failed to load favorite products")
        }
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



