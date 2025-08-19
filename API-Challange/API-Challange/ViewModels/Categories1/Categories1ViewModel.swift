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
    case loaded(filteredProducts: [ProductModel])
}


@Observable
final class Categories1ViewModel: Categories1Protocol {
    
    var state: Categories1State = .idle
    private let serviceAPI: ProductAPIServiceProtocol
    var serviceFavorites: StorePersistenceProtocol
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceFavorites = serviceFavorites
    }
    
    func toggleFavorites(_ id: Int) {
        serviceFavorites.toggleFavorite(id)
    }
    
    func loadProducts(category: CategoryModel) async {
        
        state = .isLoading
        
        do {
            
            let products = try await serviceAPI.getAllProducts()
            
            var filteredProducts: [ProductModel] = []
            
            for product in products {
                
                if product.category == category.slug {
                    
                    filteredProducts.append(product)
                    
                }
            }
            
            state = .loaded(filteredProducts: filteredProducts)
        } catch {
            
            state = .error(message: "Error to fetch categories: \(error.localizedDescription)")
            
        }
        
    }
    
}
