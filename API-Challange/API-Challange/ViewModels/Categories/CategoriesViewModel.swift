//
//  CategoriesViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation
import SwiftData

enum CategoriesState {
    case idle
    case isLoading
    case error(message: String)
    case loaded(allCategories: [CategoryModel])
}

@Observable
final class CategoriesViewModel: CategoriesViewModelProtocol {
    
    var state: CategoriesState = .idle
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func loadCategories() async {
        
        state = .isLoading
        
        do {
            
            let categories = try await service.getCategories()
            
            state = .loaded(allCategories: categories)
        } catch {
            
            state = .error(message: "Error to fetch categories: \(error.localizedDescription)")
            
        }
        
    }
    
}
