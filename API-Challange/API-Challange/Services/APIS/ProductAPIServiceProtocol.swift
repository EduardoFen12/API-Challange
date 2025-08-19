//
//  ProductServiceProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation

protocol ProductAPIServiceProtocol {
    
    func getCategories() async throws -> [CategoryModel]
    func getAllProducts() async throws -> [ProductModel]
    func getProduct(number: Int) async throws -> ProductModel
    func getRandomProduct() async throws -> ProductModel
    func getFiltredProducts(by ids: [Int]) async throws -> [ProductModel]
    func getFourRandomCategories() async throws -> [CategoryModel]
    
}
