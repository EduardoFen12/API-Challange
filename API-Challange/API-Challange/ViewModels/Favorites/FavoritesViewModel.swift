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
    
    var favorites: [Favorite] = []
    
    init(service: ProductServiceProtocol, context: ModelContext) {
        self.service = service
        
        self.context = context
    }
    
    func getFavorites() throws {
        let descriptor = FetchDescriptor<Favorite>()
        let queriedFavorites = try context.fetch(descriptor)
        favorites = queriedFavorites
    }
    
    func toggleFavorite(_ id: Int) {
        if let favID = favorites.first(where: {$0.productID == id}) {
            context.delete(favID)
            try? context.save()
            print("entrou no if")
        } else {
            context.insert(Favorite(productID: id))
            try? context.save()
            print("entrou no else")
        }
        
        Task {
            await loadingFavorites()
            
            print("recarregando")
        }
    }
    
    func loadingFavorites() async {
        state = .isLoading
        
        do {

            var favoriteProducts: [ProductModel] = []

            try getFavorites()
            
            if !favorites.isEmpty {
                
                for favorite in favorites {
                    
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



