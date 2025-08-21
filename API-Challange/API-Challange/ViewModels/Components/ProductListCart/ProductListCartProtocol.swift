//
//  ProductListCartProtocol.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 21/08/25.
//

import Foundation

protocol ProductListCartViewModelProtocol {

    var price: Double { get }
    var amount: Int { get }
    var doubleToString: String { get }
    func increaseAmount()
    func decreaseamount()
}
