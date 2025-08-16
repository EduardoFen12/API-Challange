//
//  ProductModel.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

struct ProductsFromResponseModel: Decodable {
    var products: [ProductModel]
}

struct ProductModel: Identifiable, Decodable {

    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let thumbnail: String
    
}
