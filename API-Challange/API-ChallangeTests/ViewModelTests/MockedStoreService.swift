//
//  MockedFavoriteService.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 20/08/25.
//
@testable import API_Challange
import Foundation

class MockedStoreService: StorePersistenceProtocol {
    
    var shouldFail: Bool
    
    var favoriteOne: Favorite = Favorite(productID: 1)
    var favoriteTwo: Favorite = Favorite(productID: 2)
    var arrayFavorites: [Favorite] = []
    var containerOfFavorites:[Favorite] = []
    
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
        self.arrayFavorites = [favoriteOne,favoriteTwo]
        self.containerOfFavorites = [favoriteOne, favoriteTwo]
    }
    
    func getFavorites() throws -> [API_Challange.Favorite] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }
        return arrayFavorites
    }
    
    func toggleFavorite(_ id: Int) {
        if let index = containerOfFavorites.firstIndex(where: { $0.productID == id }) {
            containerOfFavorites.remove(at: index)
        } else {
            containerOfFavorites.append(Favorite(productID: id))
        }
    }
}


