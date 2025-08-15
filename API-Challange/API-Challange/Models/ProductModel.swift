//
//  ProductModel.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import Foundation
import SwiftData

@Model
final class ProductModel: Identifiable {

    var id: Int
    var title: String
    var longDescription: String
    var category: CategoryModel
    var price: Double
    
    init(id: Int, title: String, description: String, category: CategoryModel, price: Double) {
        self.id = id
        self.title = title
        self.longDescription = description
        self.category = category
        self.price = price
    }
    
}
