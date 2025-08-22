//
//  FavoritesStore.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 16/08/25.
//
import Foundation
import Observation
import SwiftData

@Model
final class Favorite {
    @Attribute(.unique) var productID: Int
    init(productID: Int) { self.productID = productID }
}

@Model
final class Cart: Equatable {
    @Attribute(.unique)
    var productID: Int
    var quantity: Int
    
    init(productID: Int) {
        self.productID = productID
        self.quantity = 1
    }
    
    static func == (lhs: Cart, rhs: Cart) -> Bool {
        lhs.productID == rhs.productID
    }
}

@Model
final class Order {
    
    var title: String
    var date: String
    var price: Double
    var image: String
    
    init(title: String, date: String, price: Double, image: String) {
        self.title = title
        self.date = date
        self.price = price
        self.image = image
    }
}

struct CartDisplayItem: Identifiable, Equatable {
    let product: ProductModel
    let cartItem: Cart
    
    var id: Int { product.id }
    
    static func == (lhs: CartDisplayItem, rhs: CartDisplayItem) -> Bool {

        lhs.id == rhs.id
    }
}
