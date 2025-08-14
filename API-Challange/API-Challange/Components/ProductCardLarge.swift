//
//  ProductCardLarge.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 13/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    var body: some View {
        
        HStack(spacing: 16) {
        
            Image(systemName: "bag.fill")
                .resizable()
                .frame(maxWidth: 160, maxHeight: 160)
                .padding(50)
                .foregroundStyle(.fillsTertiary)
                .background(RoundedRectangle(cornerRadius: 8).fill(.fillsQuaternary))
            
            VStack(spacing: 32) {
                HStack {
                    Text("Category")
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .foregroundStyle(.labelsSecondary)
                        
                    Unfavorite()
                }
                .padding(.top, 8)
                VStack(alignment: .leading, spacing: 4){
                
                    Text("product name with two \nor more lines goes here")
                        .font(.subheadline)
                        .foregroundStyle(.labelsPrimary)
                    
                    Text("US$ 00,00")
                        .font(.headline)
                        .foregroundStyle(.labelsPrimary)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
                
        }
        .frame( maxWidth: 361, maxHeight: 176)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
    }
}

#Preview {
    ProductCardLarge()
}
