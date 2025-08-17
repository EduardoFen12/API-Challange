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
    
    @Environment(\.modelContext ) private var modelContext
    @Query var favorites: [Favorite]
    
    var isFavorite: Bool {
          favorites.contains { $0.productID == product.id }
      }
    
    @State var product: ProductModel
    
    func toggleFavorite(_ id: Int) {
        if let favID = favorites.first(where: {$0.productID == id}) {
            modelContext.delete(favID)
            try? modelContext.save()
            print("entrou no if")
        } else {
            modelContext.insert(Favorite(productID: id))
            try? modelContext.save()
            print("entrou no else")
        }
    }
    
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
                            toggleFavorite(product.id)
                            
                            for fav in favorites {
                                print(fav.productID)
                            }
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

#Preview {
    ProductCardMedium(product: ProductModel(id: 2, title: "Sei la", description: "Loooooooonnnnnggg description", category: "quauqler coisa" , price: 60.00, discountPercentage: 30.00, thumbnail: ""))}
