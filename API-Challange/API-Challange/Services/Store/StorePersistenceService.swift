//
//  ProductFavoriteService.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 18/08/25.
//

import SwiftData
import Foundation

class StorePersistenceService: StorePersistenceProtocol {
    
    var context: ModelContext
        
    init(context: ModelContext) {
        self.context = context
    }

    func getFavorites() throws -> [Favorite] {
        let descriptor = FetchDescriptor<Favorite>()
        let queriedFavorites = try context.fetch(descriptor)
        return queriedFavorites
    }
    
    func toggleFavorite(_ id: Int) {
        
        let favorites = try? getFavorites()
        
        if let favID = favorites?.first(where: {$0.productID == id}) {
            context.delete(favID)
            try? context.save()
            print("entrou no if")
        } else {
            context.insert(Favorite(productID: id))
            try? context.save()
            print("entrou no else")
        }
    }
    
    func getAllCart() throws -> [Cart] {
        let descriptor = FetchDescriptor<Cart>()
        let queriedCart = try context.fetch(descriptor)
        return queriedCart
    }
    
    func addToCart(_ id: Int) {
        context.insert(Cart(productID: id))
        try? context.save()
    }
    
    func removeFromCart(_ id: Int) {
        let cart = try? getAllCart()
        if let selectedProduct = cart?.first(where: {$0.productID == id}) {
            context.delete(selectedProduct)
            try? context.save()
        }
    }
    
    func addToQuantity(_ id: Int) {
        let cart = try? getAllCart()
        if let selectedProduct = cart?.first(where: {$0.productID == id}) {
            selectedProduct.quantity += 1
            try? context.save()
        }
    }

    func removeFromQuantity(_ id: Int) {
        let cart = try? getAllCart()
        if let selectedProduct = cart?.first(where: {$0.productID == id}) {
            if selectedProduct.quantity <= 1 {
                selectedProduct.quantity -= 1
                removeFromCart(id)
            } else {
                selectedProduct.quantity -= 1
            }
            try? context.save()
        }
    }
}
