//
//  OrdersView.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI

struct OrdersView: View {
    
    @State private var searchText = ""
    
    struct Product: Identifiable, Decodable {
        var id: UUID = UUID()
        var name: String
        var price: Double
        var month: Int
        
        init(name: String, price: Double, month: Int) {
            self.name = name
            self.price = price
            self.month = month
        }
    }
    
    var products: [Product] = [
        Product(name: "Iphone 16 Pro Max 128GB Space Gray", price: 5399, month: 1),
        Product(name: "Cadeira Gamer Recliner", price: 1200, month: 2),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, month: 2),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, month: 2),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, month: 5),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, month: 7),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, month: 10),
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if products.isEmpty {
                    EmptyState(style: .orders)
                } else {
                    VStack {
                        ScrollView {
                            VStack (spacing: 16) {
                                ForEach(products) { product in
                                    ProductListDelivery(productName: product.name, price: product.price, month: product.month)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
            .navigationTitle("Orders")
            .searchable(text: $searchText)
            
        }

    }
}

#Preview {
    TabBar()
}
