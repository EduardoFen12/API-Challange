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
    
    // MARK: - Favorites
    
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
        } else {
            context.insert(Favorite(productID: id))
            try? context.save()
        }
    }
    
    /// Busca todos os itens do carrinho.
    func getAllCart() throws -> [Cart] {
        let descriptor = FetchDescriptor<Cart>()
        return try context.fetch(descriptor)
    }

    func fetchCartItem(for productID: Int) throws -> Cart? {
        let predicate = #Predicate<Cart> { $0.productID == productID }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1 // Otimização: só precisamos de 1 resultado
        
        let items = try context.fetch(descriptor)
        return items.first
    }
    
    /// Adiciona um produto ao carrinho. Se já existir, aumenta a quantidade.
    func addToCart(_ id: Int) {
        do {
            if let existingItem = try fetchCartItem(for: id) {
                // O item já existe, então apenas incrementa a quantidade
                existingItem.quantity += 1
            } else {
                // O item não existe, insere um novo
                let newItem = Cart(productID: id)
                context.insert(newItem)
            }
            try context.save()
        } catch {
            print("Erro ao adicionar ao carrinho: \(error.localizedDescription)")
        }
    }
    
    /// Remove completamente um produto do carrinho, independentemente da quantidade.
    func removeFromCart(_ id: Int) {
        do {
            if let itemToDelete = try fetchCartItem(for: id) {
                context.delete(itemToDelete)
                try context.save()
            }
        } catch {
            print("Erro ao remover do carrinho: \(error.localizedDescription)")
        }
    }
    
    /// Aumenta a quantidade de um produto no carrinho em 1.
    func addToQuantity(_ id: Int) {
        do {
            if let itemToUpdate = try fetchCartItem(for: id) {
                itemToUpdate.quantity += 1
                try context.save()
            }
        } catch {
            print("Erro ao aumentar a quantidade: \(error.localizedDescription)")
        }
    }
    
    func removeFromQuantity(_ id: Int) {
        do {
            if let itemToUpdate = try fetchCartItem(for: id) {
                if itemToUpdate.quantity > 1 {
                    // Apenas diminui a quantidade
                    itemToUpdate.quantity -= 1
                } else {
                    // Se a quantidade for 1, remove o item do carrinho
                    context.delete(itemToUpdate)
                }
                try context.save()
            }
        } catch {
            print("Erro ao diminuir a quantidade: \(error.localizedDescription)")
        }
    }
    
    // MARK: ORDERS

    func saveToOrders(_ title: String, price: Double, image: String) {
        
        let date = Date(timeInterval: 7*86400, since: Date())
        
        let formatter = DateFormatter()
           formatter.locale = Locale(identifier: "pt_BR") 
           formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: date)
        
        let newOrder = Order(title: title, date: dateString, price: price, image: image)
        context.insert(newOrder)
        try? context.save()
    }
    
    func RecoverOrder() throws -> [Order] {
        let fetch = FetchDescriptor<Order>()
        return try context.fetch(fetch)
    }
}


