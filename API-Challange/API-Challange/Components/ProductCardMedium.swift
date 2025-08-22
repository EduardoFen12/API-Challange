//
//  SwiftUIView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI
import SwiftData

enum heart: String {
    case empty = "heart"
    case filled = "heart.fill"
}

struct ProductCardMedium: View {
    
    //isso tem que vir da viewmodel
    var favorites: [Favorite]
    var isFavorite: Bool
    var toggleFavorite: () -> Void
    
    //item recebido por navegação, pode ficar aqui
    @State var product: ProductModel
    
    
    var stringPrice: String? { NumberFormatterManager.shared.doubleToString(self.product.price)}
    
    var body: some View {
        VStack( spacing: 8) {
            
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()
                    .frame(maxWidth: 161, maxHeight: 160)
                
            } placeholder: {
                
                Placeholder(imageStyle: .medium)
                
            }
                .background(RoundedRectangle(cornerRadius: 8).fill(.fillsQuaternary))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(alignment: .topTrailing) {
                    Image(systemName: ( isFavorite ? heart.filled.rawValue : heart.empty.rawValue))
                        .frame(width: 22)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))
                        .onTapGesture {
                            
                            toggleFavorite()
    
                        }
                }
                
            VStack(alignment: .leading, spacing: 8){
            
                Text(product.title)
                    .font(.subheadline)
                    .foregroundStyle(.labelsPrimary)
                
                Text(stringPrice ?? "")
                    .font(.headline)
                    .foregroundStyle(.labelsPrimary)
                
            }
            
        }
        .frame(maxWidth: 161, maxHeight: 250)
        .padding(8)
        .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
                
    }
}
