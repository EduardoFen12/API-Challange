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
        
            Placeholder(imageStyle: .medium)
            
            VStack(alignment: .leading, spacing: 32) {
                HStack {
                    Text("Category")
                        
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .foregroundStyle(.labelsSecondary)
                        
                    Unfavorite()
                }
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
        .padding(8)
        .frame( maxWidth: 361, maxHeight: 176)
            .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
    }
}

#Preview {
    ProductCardLarge()
}
