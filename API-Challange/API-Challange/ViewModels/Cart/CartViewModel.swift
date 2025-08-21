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
            if let itemPrice = cartProducts.first(where: { $0.id == item.productID })?.price {
                total += itemPrice * Double(item.quantity)
            } else {
                total += 0
            }
        }
        return NumberFormatterManager.shared.doubleToString(total)
    }
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceStore: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceStore = serviceStore
    }
    
    func getCartProducts() async {
        do {
            if cart.isEmpty {
                state = .cartEmpty
            } else {
                let productIds = cart.map { $0.productID }
                let awaitCartProducts = try await serviceAPI.getFiltredProducts(by: productIds)
                
                cart.forEach{
                    if $0.quantity == 0 {
                        Task{
                            await loadCart()
                            await getCartProducts()
                        }
                    }
                }
                cartProducts = awaitCartProducts
                state = .loaded
            }
        } catch {
            state = .error(message: "failed to load Cart products")
        }
    }
    
    func loadCart() async {
        state = .isLoading
        
        do {
            
            cart = try serviceStore.getAllCart()
            print(cart)
            
            if cart.isEmpty {
                
                state = .cartEmpty
            }
            
        } catch {
            
            state = .error(message: "Error to fetch categories: \(error.localizedDescription)")
            
        }
    }
    
    func addToQuantity(_ id: Int) {
        serviceStore.addToQuantity(id)
    }
    
    func removeFromQuantity(_ id: Int) {
        serviceStore.removeFromQuantity(id)
    }
    
    func makeOrder() async {
        serviceStore.makeOrder()
    }
    
}
