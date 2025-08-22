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
    var date: String
    var image: String
//    @State var width: CGFloat = 361
    @State var padding: CGFloat = 16
    @State var isIpad: Bool = false
    
    var body: some View {
        
        HStack(spacing: 8) {
                        
            AsyncImage(url: URL(string: image)) { image in
                image.resizable()
                    .frame(width: 80, height: 80)
                
            } placeholder: {
                
                Placeholder(imageStyle: .small)
                
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(.fillsQuaternary))
                    
            HStack(spacing: 16) {

                VStack(spacing: 4) {
                    //Date
                    Text(date)
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
                
                Spacer(minLength: 0)
                
            }
            .padding(8)
            
            
        }
        .padding(8)
        .frame(maxWidth: .infinity, minHeight: 96, maxHeight: 96)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        .padding(.leading, padding)
        .padding(.trailing, padding)
        
    }
}

#Preview {
    ProductListDelivery(productName: "NOME", price: 0.0, date: "27/01", image: "nil", padding: 130, isIpad: true)
}
