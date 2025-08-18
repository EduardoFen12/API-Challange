//
//  ProductFavoriteProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 18/08/25.
//


protocol ProductFavoriteProtocol {
    var favorites: [Favorite] { get }
    func toggleFavorite(_ id: Int, loadFav: @escaping () async  ->Void)


    
}
