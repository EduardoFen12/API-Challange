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
