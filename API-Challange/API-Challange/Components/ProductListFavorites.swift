//
//  ProdutListDelivery.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 13/08/25.
//

import SwiftUI

struct ProductListFavorites: View {
    
    @State var isClicked: Bool = false
    
    var product: ProductModel
    var stringPrice: String? { NumberFormatterManager.shared.doubleToString(self.product.price)}
    var body: some View {
        
        HStack(spacing: 8) {
            
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()
                    .frame(maxWidth: 78, maxHeight: 78)
                
            } placeholder: {
                
                Placeholder(imageStyle: .small)

            }
            
            .background(RoundedRectangle(cornerRadius: 8).fill(.fillsQuaternary))
        
            HStack(spacing: 16) {

                VStack(spacing: 4) {
                    
                    Text(product.title)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .lineLimit(2, reservesSpace: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .leading)

                    Spacer()
                    
                    Text(stringPrice ?? "")

                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
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
                .accessibilityHidden(true)
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
    ProductListFavorites(isClicked: true, product: .init(id: 1, title: "texto titulo KKKKKKKKKKKKKKKKKKK", description: "descricao", category: "", price: 1, discountPercentage: 1, thumbnail: ""))
}
