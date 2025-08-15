//
//  CategoriesProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation

protocol CategoriesViewModelProtocol {
    var categories: [CategoryModel] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadCategories() async
}
