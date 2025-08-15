//
//  CategoriesViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation

@Observable
class CategoriesViewModel: CategoriesViewModelProtocol {
    
    var categories: [CategoryModel] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func loadCategories() async {
        isLoading = true
        
        do {
            categories = try await service.getCategories()
        } catch {
            errorMessage = "Error to fetch Categories: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
}
