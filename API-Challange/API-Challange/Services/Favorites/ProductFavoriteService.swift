//
//  ProductFavoriteService.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 18/08/25.
//

import SwiftData

class ProductFavoriteService: ProductFavoriteProtocol {
    
    var context: ModelContext
    var favorites: [Favorite] = []
    
    init(context: ModelContext) {
        self.context = context
    }

    func getFavorites() throws {
        let descriptor = FetchDescriptor<Favorite>()
        let queriedFavorites = try context.fetch(descriptor)
        favorites = queriedFavorites
    }
    
    func toggleFavorite(_ id: Int, loadFav: @escaping () async  ->Void) {
        
        try? getFavorites()
        
        if let favID = favorites.first(where: {$0.productID == id}) {
            context.delete(favID)
            try? context.save()
            print("entrou no if")
        } else {
            context.insert(Favorite(productID: id))
            try? context.save()
            print("entrou no else")
        }
        
        Task {
            await loadFav()
            
            print("recarregando")
        }
    }
    
}
