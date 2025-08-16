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
    private let service: ProductServiceProtocol
    
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func loadProducts() async {
        
        state = .loading
        
        do {
            
            let dealOfDay = try await service.getRandomProduct()
            let allProducts = try await service.getAllProducts()
            
            state = .loaded(deal: dealOfDay, products: allProducts)
        } catch {

            state = .error(message: "Error to fetch products: \(error.localizedDescription)")
            
        }
    }
}
