//
//  categories.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

//struct CategoriesFromResponseModel: Decodable {
//    var categories: [CategoryModel]
//}

struct CategoryModel: Decodable {
    
    let slug: String
    let name: String
    let url: String
    
}
