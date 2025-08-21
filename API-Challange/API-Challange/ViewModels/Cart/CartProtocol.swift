//
//  CartProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

protocol CartViewModelProtocol {
    func loadCart() async
    func getCartProducts() async
    func addToQuantity(_ id: Int)
    func removeFromQuantity(_ id: Int)
    func makeOrder() async
}
