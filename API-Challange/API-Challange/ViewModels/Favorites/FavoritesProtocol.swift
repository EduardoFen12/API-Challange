//
//  FavoritesProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 16/08/25.
//

protocol FavoritesProtocol {
    
    func loadingFavorites() async
    func getFavoriteProducts() async
    func search(by name: String)
}
