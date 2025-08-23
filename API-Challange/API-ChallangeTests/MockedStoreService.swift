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
    var orderOne = Order(title: "testeSearch", date: "27/01", price: 0, image: "")
    var orderTwo = Order(title: "testeSearch", date: "27/01", price: 0, image: "")
    
    var cartOne = Cart(productID: 1)
    var cartTwo = Cart(productID: 2)
    var arrayOfCart: [Cart]
    var arrayOfOrders: [Order] = []
    var lastChangedTotalPrice: Double?
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
        self.arrayFavorites = [favoriteOne,favoriteTwo]
        self.containerOfFavorites = [favoriteOne, favoriteTwo]
        self.arrayOfCart = [cartOne, cartTwo]
        self.arrayOfOrders = [orderOne, orderTwo]
    }
    
    
    // MARK: - FAVORITES
    
    func getFavorites() throws -> [Favorite] {
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
    
    // MARK: - CART
    
    func getAllCart() throws -> [Cart] {
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
    
    func fetchCartItem(for productID: Int) throws -> API_Challange.Cart? {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }
        return arrayOfCart.first { $0.productID == productID }
    }
    
    //MARK: - ORDERS
    
    func saveToOrders(_ title: String, price: Double, image: String) {
        let date = Date(timeInterval: 7*86400, since: Date())
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: date)
        let newOrder = API_Challange.Order(title: title, date: dateString, price: price, image: image)
        arrayOfOrders.append(newOrder)
    }

    func RecoverOrder() throws -> [Order] {
        if shouldFail {
            throw MockAPIError.forcedFailure
        }
        return arrayOfOrders
    }
}
