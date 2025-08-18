//
//  DetailView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 16/08/25.
//

// DetailView.swift
import SwiftUI

struct DetailView: View {
    let name: String
    let price: Double
    let description: String

    var body: some View {
        NavigationStack {
            ProductDetails(
                name: name,
                price: price,
                description: description
            )
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    DetailView(name: "oi", price: 4.4, description: "oioioi")
}
