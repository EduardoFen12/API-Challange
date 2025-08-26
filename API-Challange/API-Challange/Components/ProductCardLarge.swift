//
//  ProductCardLarge.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 13/08/25.
//

import SwiftUI
import SwiftData

struct ProductCardLarge: View {
    
    var isFavorite: Bool
    var toggleFavorite: () -> Void
    var product: ProductModel
    var stringPrice: String? { NumberFormatterManager.shared.doubleToString(self.product.price)}
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()

            } placeholder: {
                
                Placeholder(imageStyle: .medium)
                
            }
            .background(RoundedRectangle(cornerRadius: 8).fill(.fillsQuaternary))
            VStack(alignment: .leading, spacing: 32) {
                HStack {
                    
                    Text(product.stringLocalized)
                        .accessibilityHidden(true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .foregroundStyle(.labelsSecondary)
                    
                    Image(systemName: ( isFavorite ? heart.filled.rawValue : heart.empty.rawValue))
                        .font(.system(size: 20))
                        .frame(width: 22, height: 22)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))
                        .onTapGesture {
                            toggleFavorite()
                        }
                        .accessibilityHidden(true)
                }
                
                VStack(alignment: .leading, spacing: 4){
                    
                    Text(product.title)
                        .font(.subheadline)
                        .foregroundStyle(.labelsPrimary)
                    
                    Text(stringPrice ?? "nil return")
                        .font(.headline)
                        .foregroundStyle(.labelsPrimary)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(product.title), \(stringPrice ?? "")")
        .accessibilityHint("double tap to see details")
        .accessibilityAddTraits(.isButton)
        .accessibilityAction(named: "Toggle favorite") {
            toggleFavorite()
        }
        .padding(8)
        .frame( maxWidth: 361, maxHeight: 176)
        .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
    }
}
