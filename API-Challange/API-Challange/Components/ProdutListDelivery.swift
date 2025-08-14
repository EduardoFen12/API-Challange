//
//  ProdutListDelivery.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 13/08/25.
//

import SwiftUI

struct ProdutListDelivery: View {
    
    var productName: String
    var price: Float
    @State var isClicked: Bool = false
    
    var body: some View {
        
        HStack(spacing: 8) {
            
            Placeholder(imageStyle: .small)
                    
            HStack(spacing: 16) {

                VStack(spacing: 4) {
                    
                    Text(productName)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    
                    Text("US$ \(String(format: "%05.2f", price))")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                }
                .frame(width: 189, height: 62)
                
                Button {
                    isClicked.toggle()
                } label: {
                    Image(systemName: "cart.fill")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.fillsTertiary)
                                .frame(width: 38, height: 38)
                        )
                }
                .padding(8)
                
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
    ProdutListDelivery(productName: "Product name with two or more lines goes here", price: 0)
}
