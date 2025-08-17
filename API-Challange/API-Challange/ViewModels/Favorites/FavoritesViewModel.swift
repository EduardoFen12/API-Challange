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
    
    private let context: ModelContext
    
    var state: FavoriteState = .idle
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol, context: ModelContext) {
        self.service = service
        
        self.context = context
    }
    
    func getFavorites() throws -> [Favorite] {
        let descriptor = FetchDescriptor<Favorite>()
        return try context.fetch(descriptor)
    }
    
    func loadingFavorites() async {
        state = .isLoading
        
        do {

            var favoriteProducts: [ProductModel] = []

            let allFavoritesIds = try getFavorites()
            
            if !allFavoritesIds.isEmpty {
                
                for favorite in allFavoritesIds {
                    
                    let favoriteProduct = try await service.getProduct(number: favorite.productID)
                    
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



