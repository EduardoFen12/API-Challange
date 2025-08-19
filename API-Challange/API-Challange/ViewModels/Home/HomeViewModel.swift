//
//  HomeViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI
import Observation

enum HomeState {
    case idle
    case loading
    case error(message: String)
    case loaded(deal: ProductModel, products: [ProductModel])
}

@Observable
final class HomeViewModel: HomeProtocol {
    
    var state: HomeState = .idle 
    private let serviceAPI: ProductAPIServiceProtocol
    var serviceFavorites: ProductFavoriteProtocol
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: ProductFavoriteProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceFavorites = serviceFavorites
        
    }
    
    func toggleFavorites(_ id: Int) {
        
        serviceFavorites.toggleFavorite(id)

    }
    
    func loadProducts() async {
        
        state = .loading
        
        do {
            
            let dealOfDay = try await serviceAPI.getRandomProduct()
            let allProducts = try await serviceAPI.getAllProducts()
            
            state = .loaded(deal: dealOfDay, products: allProducts)
        } catch {

            state = .error(message: "Error to fetch products: \(error.localizedDescription)")
            
        }
    }
}
