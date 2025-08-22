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

struct CartDisplayItem: Identifiable, Equatable {
    let product: ProductModel
    let cartItem: Cart
    
    var id: Int { product.id }
    
    // 👇 Adicione esta função para resolver o erro
    static func == (lhs: CartDisplayItem, rhs: CartDisplayItem) -> Bool {
        // Diz ao Swift que dois itens são iguais se seus IDs forem iguais.
        lhs.id == rhs.id
    }
}

@Observable
final class CartViewModel: CartViewModelProtocol {
    var state: CartState = .idle
    var serviceAPI: ProductAPIServiceProtocol
    var serviceStore: StorePersistenceProtocol
    
    var cartDisplayItems: [CartDisplayItem] = []
    
    var totalPrice: String {
        let total = cartDisplayItems.reduce(0) { partialResult, item in
            let itemSubtotal = item.product.price * Double(item.cartItem.quantity)
            return partialResult + itemSubtotal
        }
        return NumberFormatterManager.shared.doubleToString(total)
    }
    
    init(serviceAPI: ProductAPIServiceProtocol, serviceStore: StorePersistenceProtocol) {
        self.serviceAPI = serviceAPI
        self.serviceStore = serviceStore
    }
    
    func loadCart() async {
        state = .isLoading
        
        do {
            // 1. Pega os itens do carrinho (1 consulta ao DB)
            let cartItemsFromDB = try serviceStore.getAllCart()
            
            if cartItemsFromDB.isEmpty {
                state = .cartEmpty
                self.cartDisplayItems = [] // Limpa a lista para a UI
                return
            }
            
            // 2. Pega os IDs para a chamada de API
            let productIds = cartItemsFromDB.map { $0.productID }
            
            // 3. Busca os detalhes dos produtos (1 chamada de API)
            let productsFromAPI = try await serviceAPI.getFiltredProducts(by: productIds)
            
            // 4. Combina os resultados na lista que a View irá usar
            self.cartDisplayItems = productsFromAPI.compactMap { product in
                if let cartItem = cartItemsFromDB.first(where: { $0.productID == product.id }) {
                    return CartDisplayItem(product: product, cartItem: cartItem)
                }
                return nil
            }
            
            state = .loaded
            
        } catch {
            state = .error(message: "Falha ao carregar o carrinho: \(error.localizedDescription)")
        }
    }
    
    func increaseQuantity(for item: CartDisplayItem) {
        serviceStore.addToQuantity(item.id)
        // Recarrega os dados para refletir a mudança no preço total e na quantidade.
        Task { await self.loadCart() }
    }
    
    func decreaseQuantity(for item: CartDisplayItem) {
        serviceStore.removeFromQuantity(item.id)
        Task { await self.loadCart() }
    }
    
    func removeItem(for item: CartDisplayItem) {
        serviceStore.removeFromCart(item.id)
        Task { await self.loadCart() }
    }
}
