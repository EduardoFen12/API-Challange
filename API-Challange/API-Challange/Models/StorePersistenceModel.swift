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
final class Cart {
    @Attribute(.unique)
    var productID: Int
    var quantity: Int
    
    init(productID: Int) {
        self.productID = productID
        self.quantity = 1
    }
}

@Model
final class Orders {
    @Attribute(.unique)
    var productID: Int
    var date: Date
    
    init(productID: Int, date: Date) {
        self.productID = productID
        self.date = Date()
    }
}
