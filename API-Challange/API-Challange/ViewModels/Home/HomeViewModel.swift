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
    case error
    case loaded
}

@Observable
final class HomeViewModel: HomeProtocol {
    
    var state: HomeState = .idle
    let serviceAPI: ProductAPIServiceProtocol
    var storeFavorites: StorePersistenceProtocol
    var dealOfDay: ProductModel
    var products: [ProductModel]
    var errorMessage: String?
    var favorites: [Favorite] = []
    
    init(serviceAPI: ProductAPIServiceProtocol, storeFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.storeFavorites = storeFavorites
        
        self.dealOfDay = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")
        self.products = []

    }
    

    func toggleFavorite(_ id: Int) {
        storeFavorites.toggleFavorite(id)
        try?  getFavorites()
    }
    
    func getFavorites() throws {
        do {
            favorites = try storeFavorites.getFavorites()
        } catch {
            print("Erro ao carregar favoritos: \(error.localizedDescription)")        }
    }
    

    func isFavorite(_ id: Int) -> Bool {
        favorites.contains(where: { $0.productID == id })
    }
    

    @MainActor
    func loadProducts() async {
//        state = .loading
        try? getFavorites()
        
        do {

            async let deal = serviceAPI.getRandomProduct()
            async let allProducts = serviceAPI.getAllProducts()
            
            self.dealOfDay = try await deal
            self.products = try await allProducts
            
            state = .loaded
        } catch {
            errorMessage = "Error fetching products: \(error.localizedDescription)"
            state = .error
        }
    }
}


