//
//  HomeViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI

@Observable
class HomeViewModel: HomeProtocol {
    
    var dealPickProduct: ProductModel?
    var products: [ProductModel] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func loadProducts() async {
        isLoading = true
        
        do {
            
            dealPickProduct = try await service.getProduct(number: 2)
            products = try await service.getAllProducts()
            
        } catch {
            
            errorMessage = "Error to fetch products: \(error.localizedDescription)"
            
        }
        isLoading = false
    }
}
