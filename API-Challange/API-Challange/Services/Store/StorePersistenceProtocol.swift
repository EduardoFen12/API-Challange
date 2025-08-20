//
//  ProductFavoriteProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 18/08/25.
//


protocol StorePersistenceProtocol {
    func getFavorites() throws -> [Favorite]
    func toggleFavorite(_ id: Int)
    func getAllCart() throws -> [Cart]
    func addToCart(_ id: Int)
    func removeFromCart(_ id: Int)
    func addToQuantity(_ id: Int)
    func removeFromQuantity(_ id: Int)
}
