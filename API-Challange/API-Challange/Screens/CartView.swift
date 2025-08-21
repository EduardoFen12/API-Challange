//
//  CartView.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct CartView: View {
    
    //receber um produto, tirar isso aqui dai
    
    struct Product: Identifiable, Decodable {
        var id: UUID = UUID()
        var name: String
        var price: Double
        var quantity: Int
        
        init(name: String, price: Double, quantity: Int) {
            self.name = name
            self.price = price
            self.quantity = quantity
        }
    }
    
    var products: [Product] = [
        Product(name: "Iphone 16 Pro Max 128GB Space Gray", price: 5399, quantity: 1),
        Product(name: "Cadeira Gamer Recliner", price: 1200, quantity: 1),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, quantity: 2),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, quantity: 2),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, quantity: 2),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, quantity: 2),
        Product(name: "Memoria Ram 32GB DDR5", price: 569, quantity: 2),
    ]
    
    var totalPrice: Double {
        products.reduce(0) { partialResult, product in
            partialResult + (product.price * Double(product.quantity))
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                if products.isEmpty {
                    EmptyState(style: .cart)
                } else {
                    VStack {
                        ScrollView {
                            VStack (spacing: 16) {
                                ForEach(products) { product in
                                    ProductListCart(productName: product.name, price: product.price, quantity: product.quantity)
                                }
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Total:")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundStyle(.labelsPrimary)
                                Spacer()
                                Text("US$ \(String(format: "%05.2f", totalPrice))")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.labelsPrimary)
                            }
                            
                            Button {
                                print("Botão Checkout clicado!")
                            } label: {
                                Text("Checkout")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.labelsPrimary)
                                    .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .foregroundStyle(.fillsTertiary)
                                    )
                            }
                            
                        }
                        .padding(.leading)
                        .padding(.trailing)
                    }
                }
            }
            .padding(.bottom)
            .navigationTitle("Cart")
        }
    }
}

#Preview {
    TabBar()
}
