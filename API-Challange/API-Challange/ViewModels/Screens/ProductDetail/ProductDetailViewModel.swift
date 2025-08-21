//
//  ProductDetailViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI

struct ProductDetailViewModel: ProductDetailProtocol {
    
    var storeService: StorePersistenceService
    
    init(storeService: StorePersistenceService) {
        self.storeService = storeService
    }
    
    func addToCart(_ id: Int) {
        self.storeService.addToCart(id)
    }

    
}
