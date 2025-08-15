//
//  categories.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//
import Foundation

struct CategoryModel: Identifiable, Decodable {
    var id = UUID()
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
