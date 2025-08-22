//
//  ProductFavoriteProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 18/08/25.
//

import Foundation

protocol StorePersistenceProtocol {
    //Favorites
    func getFavorites() throws -> [Favorite]
    func toggleFavorite(_ id: Int)
    
    //Cart
    func getAllCart() throws -> [Cart]
    func fetchCartItem(for productID: Int) throws -> Cart?
    func addToCart(_ id: Int)
    func removeFromCart(_ id: Int)
    func addToQuantity(_ id: Int)
    func removeFromQuantity(_ id: Int)
    
    //Orders
    func saveToOrders(_ title: String, price: Double, image: String)
    func RecoverOrder() throws -> [Order]
}
