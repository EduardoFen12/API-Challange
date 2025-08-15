//
//  HomeProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//
import Foundation

protocol HomeProtocol {
    
    var dealPickProduct: ProductModel? { get }
    var products: [ProductModel] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func loadProducts() async
    
}
