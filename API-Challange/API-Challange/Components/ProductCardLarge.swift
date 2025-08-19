//
//  ProductCardLarge.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 13/08/25.
//

import SwiftUI
import SwiftData

struct ProductCardLarge: View {
    
    @Environment(\.modelContext ) private var modelContext
    @Query var favorites: [Favorite]
    
    var isFavorite: Bool {
          favorites.contains { $0.productID == product.id }
      }
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
                    
                    Text(product.category)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.footnote)
                        .foregroundStyle(.labelsSecondary)
                    
                    Image(systemName: ( isFavorite ? heart.filled.rawValue : heart.empty.rawValue))
                        .frame(width: 22)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))
                        .onTapGesture {
                            toggleFavorite()
                            
                            for fav in favorites {
                                print(fav.productID)
                            }
                        }
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
        .padding(8)
        .frame( maxWidth: 361, maxHeight: 176)
        .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
    }
}

//#Preview {
//    ProductCardLarge(product: ProductModel(id: 2, title: "Sei la", description: "Loooooooonnnnnggg description", category: "quauqler coisa" , price: 60.00, discountPercentage: 30.00, thumbnail: ""))
//}
