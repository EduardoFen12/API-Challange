//
//  ProductFavoriteService.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 18/08/25.
//

import SwiftData
import Foundation

class ProductFavoriteService: ProductFavoriteProtocol {
    
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }

    func getFavorites() throws -> [Favorite] {
        let descriptor = FetchDescriptor<Favorite>()
        let queriedFavorites = try context.fetch(descriptor)
        return queriedFavorites
    }
    
    func toggleFavorite(_ id: Int) {
        
        let descriptor = FetchDescriptor<Favorite>()
        let favorites = try? context.fetch(descriptor)
        
        if let favID = favorites?.first(where: {$0.productID == id}) {
            context.delete(favID)
            try? context.save()
            print("entrou no if")
        } else {
            context.insert(Favorite(productID: id))
            try? context.save()
            print("entrou no else")
        }
        
    }
    
}
