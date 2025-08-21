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
    private let serviceAPI: ProductAPIServiceProtocol
    private var serviceFavorites: StorePersistenceProtocol
    
    // Propriedades agora inicializadas
    var dealOfDay: ProductModel
    var products: [ProductModel]
    var errorMessage: String
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceFavorites: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceFavorites = serviceFavorites
        
        
        self.dealOfDay = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")
        self.products = []
        self.errorMessage = ""
    }
    
    func toggleFavorite(_ id: Int) {
        serviceFavorites.toggleFavorite(id)
    }
    
    func loadProducts() async {
        state = .loading
        
        do {
            dealOfDay = try await serviceAPI.getRandomProduct()
            products = try await serviceAPI.getAllProducts()
            state = .loaded
        } catch {
            // Linha corrigida, sem o parêntese extra
            errorMessage = "Error to fetch products: \(error.localizedDescription)"
            state = .error
        }
    }
}


