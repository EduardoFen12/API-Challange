//
//  SwiftUIView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct ProductCardMedium: View {
    var body: some View {
        VStack( spacing: 8) {
            
            Placeholder(imageStyle: .large)
                .background(RoundedRectangle(cornerRadius: 8).fill(.fillsQuaternary))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "heart")
                        .frame(width: 22)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))
                }
            VStack(alignment: .leading, spacing: 8){
            
                Text("Product name with two or more lines goes here")
                    .font(.subheadline)
                    .foregroundStyle(.labelsPrimary)
                
                Text("US$ 00,00")
                    .font(.headline)
                    .foregroundStyle(.labelsPrimary)
                
            }
            .frame(maxWidth: 161)
            
        }
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
        
        
    }
}

#Preview {
    ProductCardMedium()
}
