//
//  CartProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

protocol CartViewModelProtocol {

    var cartDisplayItems: [CartDisplayItem] { get }
    var totalPrice: String { get }
    

    func loadCart() async
    
    func increaseQuantity(for item: CartDisplayItem)
    
    func decreaseQuantity(for item: CartDisplayItem)
    
    func removeItem(for item: CartDisplayItem)
}
