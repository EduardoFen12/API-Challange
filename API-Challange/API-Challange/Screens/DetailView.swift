//
//  DetailView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 16/08/25.
//

// DetailView.swift
import SwiftUI

struct DetailView: View {
    
    let product: ProductModel
    let toggleFavorite: () -> Void

    var body: some View {
        NavigationStack {
            ProductDetails(product: product, toggleFavorite: toggleFavorite )
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


//#Preview {
//    DetailView(product: ProductModel(id: 2, title: "", description: "", category: "", price: 2.2, discountPercentage: 2.2, thumbnail: ""), toggleFavorite: {}())
//}
