//
//  ProductService.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation

struct ProductService: ProductServiceProtocol {
    
    private let baseURL = "https://dummyjson.com"
    
    func getCategories() async throws -> [CategoryModel] {
        
        let urlString: String = "\(baseURL)/products/categories"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let categories = try JSONDecoder().decode([CategoryModel].self, from: data)
        
        return categories
        
    }

    func getAllProducts() async throws -> [ProductModel] {
        let urlString: String = "\(baseURL)/products"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductsFromResponseModel.self, from: data)
        
        return response.results
    }
    
    func getProduct(number: Int) async throws -> ProductModel {
        let urlString: String = "\(baseURL)/products/\(number)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let product = try JSONDecoder().decode(ProductModel.self, from: data)
        
        return product
    }
    
}
