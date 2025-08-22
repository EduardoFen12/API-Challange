//
//  ProductDetailViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI

struct ProductDetailViewModel: ProductDetailProtocol {
    
    var storeService: StorePersistenceService
    var product: ProductModel
    var stringPrice: String { NumberFormatterManager.shared.doubleToString(product.price)}
    
    init(storeService: StorePersistenceService, product: ProductModel) {
        self.storeService = storeService
        self.product = product
    }
    
    func addToCart(_ id: Int) {
        self.storeService.addToCart(id)
    }

    
}
