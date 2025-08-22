//
//  OrdersViewModel.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import Foundation

enum OrdersViewState {
    case idle
    case loading
    case loaded
    case isEmpty
    case error
}

@Observable
class OrdersViewModel: OrdersProtocol {
    
    var orders: [Order] = []
    var errorMessage: String = ""
    var storeService: StorePersistenceProtocol
    var state: OrdersViewState = .idle
    
    init(storeService: StorePersistenceProtocol) {
        self.storeService = storeService
    }
    
    func loadView() async {
        state = .loading
        
        do {
            
            async let allOrders =  storeService.RecoverOrder()
            self.orders = try await allOrders
            
            if  orders.isEmpty {
                
                state = .isEmpty
                
            } else {
                
                state = .loaded
            }
            
        } catch {
            state = .error
            errorMessage = "Error fetching orders: \(error.localizedDescription)"
        }
    }
}
