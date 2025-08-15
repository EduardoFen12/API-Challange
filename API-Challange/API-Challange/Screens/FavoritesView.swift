//
//  Favorites.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI

struct FavoritesView: View {
    
    @State private var searchText = ""
    @State private var showCartSheet = false
    
    struct Product: Identifiable, Decodable {
        var id: UUID = UUID()
        var name: String
        var price: Double
        
        init(name: String, price: Double) {
            self.name = name
            self.price = price
        }
    }
    
    var products: [Product] = [
        Product(name: "Iphone 16 Pro Max 128GB Space Gray", price: 5399),
        Product(name: "Cadeira Gamer Recliner", price: 1200),
        Product(name: "Memoria Ram 32GB DDR5", price: 569),
        Product(name: "Memoria Ram 32GB DDR5", price: 569),
        Product(name: "Memoria Ram 32GB DDR5", price: 569),
        Product(name: "Memoria Ram 32GB DDR5", price: 569),
        Product(name: "Memoria Ram 32GB DDR5", price: 569),
    ]

    
    var body: some View {

        NavigationStack {
            VStack(spacing: 16) {
                if products.isEmpty {
                    EmptyState(style: .favorites)
                } else {
                    VStack {
                        ScrollView {
                            VStack (spacing: 16) {
                                ForEach(products) { product in
                                    Button {
                                        showCartSheet = true
                                    } label: {
                                        ProductListFavorites(productName: product.name, price: product.price)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
            .navigationTitle("Favorites")
            .searchable(text: $searchText)
            .sheet(isPresented: $showCartSheet) {
                
                NavigationStack {
                    ProductDetails(name: "Iphone 16 Pro Max 128GB Space Gray", price: 5399, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis nec mauris ac placerat. Cras pulvinar dolor at orci semper hendrerit. Nam elementum leo vitae quam commodo, blandit ultricies diam malesuada. Suspendisse lacinia euismod quam interdum mollis. Pellentesque a eleifend ante. Aliquam tempus ultricies velit, eget consequat magna volutpat vitae. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris pulvinar vestibulum congue. Aliquam et magna ultrices justo condimentum varius.")
                        .navigationTitle("Details")
                        .navigationBarTitleDisplayMode(.inline)
                }
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
            }
            
        }
        
    }
}

#Preview {
    TabBar()
}
