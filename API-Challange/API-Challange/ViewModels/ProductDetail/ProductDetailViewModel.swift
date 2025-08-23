//
//  ProductDetailViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI

class ProductDetailViewModel: ProductDetailProtocol {
    
    var storeService: StorePersistenceProtocol
    var product: ProductModel
    var stringPrice: String { NumberFormatterManager.shared.doubleToString(product.price)}
    
    init(storeService: StorePersistenceProtocol, product: ProductModel) {
        self.storeService = storeService
        self.product = product
    }
   
    func addToCart(_ id: Int) {
        self.storeService.addToCart(id)
    }
}

