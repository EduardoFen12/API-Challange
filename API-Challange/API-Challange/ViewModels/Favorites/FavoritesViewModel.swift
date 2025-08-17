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
//    var favs: FavoritesStore
    
    init(service: ProductServiceProtocol, context: ModelContext/*, favs: FavoritesStore*/) {
        self.service = service
//        self.favs = favs
        
        self.context = context
    }
    
    func getFavorites() throws -> [Favorite] {
        let descriptor = FetchDescriptor<Favorite>()
        return try context.fetch(descriptor)
    }
    
    func loadingFavorites() async {
        state = .isLoading
        
        do {
            
//            if !favs.ids.isEmpty {
//                
//                var allFavorites: [ProductModel] = []
//
//                for id in favs.ids {
                    
//                    let favorite = try await service.getProduct(number: id)
//                    allFavorites.append(favorite)
//                    print(favorite.price)
//                }
//            print(try getFavorites().first?.productID)
                let allProducts = try await service.getAllProducts()
                
                state = .loaded( allFavorites: allProducts)

//                } else {
//
//                state = .favsEmpty
//            }
            
        } catch {
            
            state = .error(message: "Error to fetch products: \(error.localizedDescription)")
            
        }
    }
}



