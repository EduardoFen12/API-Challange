//
//  CategoriesModel.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftData

@Model
class CategoryModel {

    var name: String
    
    init(name: String) {
        self.name = name
    }
}
