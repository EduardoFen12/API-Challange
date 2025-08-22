//
//  OrdersProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//
//

protocol OrdersProtocol {
    var orders: [Order] { get set }
    func search(by name: String)
}
