//
//  ProductFavoriteProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 18/08/25.
//


protocol StorePersistenceProtocol {
    func getFavorites() throws -> [Favorite]
    func toggleFavorite(_ id: Int)
}
