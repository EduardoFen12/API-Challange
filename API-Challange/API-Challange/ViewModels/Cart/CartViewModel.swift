//
//  CartViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation
import SwiftData

enum CartState {
    case idle
    case isLoading
    case error(message: String)
    case loaded
    case cartEmpty
}

@Observable
final class CartViewModel: CartViewModelProtocol {
        
    var state: CartState = .idle
    var serviceAPI: ProductAPIServiceProtocol
    var serviceStore: StorePersistenceProtocol
    var cart: [Cart] = []
    var cartProducts: [ProductModel] = []
    var totalPrice: String  {
        Task {
            await getCartProducts()
        }
        var total: Double = 0
        for item in cart {
            total = cartProducts.first(where: { $0.id == item.productID })!.price + total
        }
        return NumberFormatterManager.shared.doubleToString(total)
    }
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceStore: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceStore = serviceStore
    }
    
    func getCartProducts() async {
        do {
            let productIds = cart.map { $0.productID }
            let awaitCartProducts = try await serviceAPI.getFiltredProducts(by: productIds)
            awaitCartProducts.forEach{print($0.id)}
            cartProducts = awaitCartProducts
            state = .loaded
        } catch {
            state = .error(message: "failed to load favorite products")
        }
    }
    
    func loadCartProducts() async {
        state = .isLoading
        
        do {
            
            cart = try serviceStore.getAllCart()
            
            if cart.isEmpty {
                
                state = .cartEmpty
            }
            
        } catch {
            
            state = .error(message: "Error to fetch categories: \(error.localizedDescription)")
            
        }
    }
    
}
