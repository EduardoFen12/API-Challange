//
//  ProdutListFavorite.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 13/08/25.
//

import SwiftUI

struct ProductListDelivery: View {
    
    var productName: String
    var price: Double
    var month: Int
    
    var body: some View {
        
        HStack(spacing: 8) {
            
            Placeholder(imageStyle: .small)
                    
            HStack(spacing: 16) {

                VStack(spacing: 4) {
                    
                    Text("DELIVERY BY MONTH, \(String(format: "%02d", month))")
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.labelsSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(productName)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("US$ \(String(format: "%05.2f", price))")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                }
                .frame(width: 241, height: 62)
                
            }
            .padding(8)
            
            
        }
        .padding(8)
        .frame(maxWidth: .infinity, minHeight: 94)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        .padding(.leading)
        .padding(.trailing)
        
    }
}

#Preview {
    ProductListDelivery(productName: "Product name with two or more lines goes here", price: 0, month: 1)
}
