//
//  ProductModel.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

struct ProductFromResponseModel: Decodable {
    var results: [ProductModel]
}

struct ProductModel: Identifiable, Decodable {

    var id: Int
    var title: String
    var longDescription: String
    var category: CategoryModel
    var price: Double
    
}
