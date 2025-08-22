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
    case loaded
}

@Observable
final class CategoriesViewModel: CategoriesViewModelProtocol {
    
    private let service: ProductAPIServiceProtocol
    
    var state: CategoriesState = .idle
    var fourRandomCategories: [CategoryModel] = []
    var allCategories: [CategoryModel] = []
    
    init(service: ProductAPIServiceProtocol) {
        self.service = service
    }
    
    func loadCategories() async {
                
        do {
            
            fourRandomCategories = try await service.getFourRandomCategories()
            allCategories = try await service.getCategories()
            
            state = .loaded
        } catch {
            
            state = .error(message: "Error to fetch categories: \(error.localizedDescription)")
            
        }
        
    }
    
    func search(by name: String) {
        if !name.isEmpty {
            allCategories = allCategories.filter {$0.slug.localizedCaseInsensitiveContains(name)}
        }
    }
    
}
