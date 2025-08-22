//
//  Categories1ViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI
import SwiftData

enum Categories1State {
    case idle
    case isLoading
    case error(message: String)
    case loaded
}


@Observable
final class Categories1ViewModel: Categories1Protocol {
    
    var state: Categories1State = .idle
    private let serviceAPI: ProductAPIServiceProtocol
    var storePresistence: StorePersistenceProtocol
    var favorites: [Favorite] = []
    var productsFromCategory: [ProductModel] = []
    
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.storePresistence = serviceFavorites
    }
    
    func toggleFavorite(_ id: Int) {
        storePresistence.toggleFavorite(id)
        getFavorites()
    }
    
    func getFavorites() {
        do {

            favorites = try storePresistence.getFavorites()
            
        } catch {
            
            print(error.localizedDescription)
            
        }
    }
    
    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(where: {$0.productID == id})
    }
    
    func loadProducts(category: CategoryModel) async {
        
        getFavorites()
        
        do {
            let products = try await serviceAPI.getProductsByCategory(by: category.slug)
            
            productsFromCategory = products
            
            state = .loaded
        } catch {
            
            state = .error(message: "Error to fetch categories: \(error.localizedDescription)")
            
        }
        
    }
    
}
