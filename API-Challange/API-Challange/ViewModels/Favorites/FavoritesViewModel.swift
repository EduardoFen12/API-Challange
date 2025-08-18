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
    case loaded(allFavorites: [ProductModel])
    case favsEmpty
}

@Observable
final class FavoritesViewModel: FavoritesProtocol {
        
    var state: FavoriteState = .idle
    var serviceAPI: ProductAPIServiceProtocol
    let serviceFavorites: ProductFavoriteProtocol
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: ProductFavoriteProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceFavorites = serviceFavorites
    }
        
    
    func loadingFavorites() async {
        state = .isLoading
        
        do {

            var favoriteProducts: [ProductModel] = []
            
            if !serviceFavorites.favorites.isEmpty {
                
                for favorite in serviceFavorites.favorites {
                    
                    let favoriteProduct = try await serviceAPI.getProduct(number: favorite.productID)
                    
                    favoriteProducts.append(favoriteProduct)
                    
                }
                
                state = .loaded(allFavorites: favoriteProducts)
                
            } else {
                
                state = .favsEmpty
                
            }
                
        } catch {
            
            state = .error(message: "Error to fetch products: \(error.localizedDescription)")
            
        }
    }
}



