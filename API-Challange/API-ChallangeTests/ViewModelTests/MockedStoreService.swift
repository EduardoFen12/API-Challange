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
    
    var cartOne = Cart(productID: 1)
    var cartTwo = Cart(productID: 2)
    var arrayOfCart: [Cart]
    var lastChangedTotalPrice: Double?
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
        self.arrayFavorites = [favoriteOne,favoriteTwo]
        self.containerOfFavorites = [favoriteOne, favoriteTwo]
        self.arrayOfCart = [cartOne, cartTwo]
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
    
    func getAllCart() throws -> [API_Challange.Cart] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }
        return arrayOfCart
    }
    
    func addToCart(_ id: Int) {
        if !arrayOfCart.contains(where: { $0.productID == id }) {
            arrayOfCart.append(Cart(productID: id))
        }
    }
    
    func removeFromCart(_ id: Int) {
        if let index = arrayOfCart.firstIndex(where: { $0.productID == id }) {
            arrayOfCart.remove(at: index)
        }
    }
    
    func addToQuantity(_ id: Int) {
        if let index = arrayOfCart.firstIndex(where: { $0.productID == id }) {
            arrayOfCart[index].quantity += 1
        }
    }
    
    func removeFromQuantity(_ id: Int) {
        if let index = arrayOfCart.firstIndex(where: { $0.productID == id }) {
            if arrayOfCart[index].quantity > 1 {
                arrayOfCart[index].quantity -= 1
            }
        }
    }
    
    func changeCartAmount(_ totalPrice: Double) {
        self.lastChangedTotalPrice = totalPrice
    }
    
}
