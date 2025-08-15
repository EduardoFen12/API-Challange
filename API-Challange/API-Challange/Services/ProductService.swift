//
//  ProductService.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation

class ProductService: ProductServiceProtocol {
    
    private let baseURL = "https://dummyjson.com"
    
    func getCategories() async throws -> [CategoryModel] {
        <#code#>
    }
    
    func getAllProducts() async throws -> [ProductModel] {
        let urlString: String = "\(baseURL)/products"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductModel.self, from: data)
    }
    
    func getProduct(number: Int) async throws -> ProductModel {
        <#code#>
    }
}
