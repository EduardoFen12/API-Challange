//
//  ProductDetails.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI
import SwiftData

struct ProductDetailsView: View {
    
    //esses dois podem ficar aqui
    let product: ProductModel
    @Environment(\.dismiss) private var dismiss
    var isFavorite: Bool {
        favorites.contains { $0.productID == product.id }
    }
    
    
    //esse cara deveria vir de uma viewmodel
    var stringPrice: String? { NumberFormatterManager.shared.doubleToString(self.product.price)}
    
    //esse modelcontext e esse favorites deveriam vir lá dos serviços
    @Environment(\.modelContext ) private var modelContext
    @Query var favorites: [Favorite]
    
    var toggleFavorite: () -> Void
    
    var body: some View {
        
        NavigationStack {
            VStack{
                ScrollView {
                    VStack(alignment: .leading, spacing: 16){
                        
                        AsyncImage(url: URL(string: product.thumbnail)) { image in
                            image.resizable()
                        } placeholder: {
                            
                            Placeholder(imageStyle: .large)
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(alignment: .topTrailing) {
                            Image(systemName: (isFavorite ? heart.filled : heart.empty).rawValue)
                                .font(.system(size: 28))
                                .frame(width: 34, height: 34)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.graysGray5))
                                .onTapGesture {
                                    toggleFavorite()
                                    dismiss()
                                    for fav in favorites {
                                        print(fav.productID)
                                    }
                                }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 32).fill(.backgroundsSecondary))
                        
                        VStack(spacing: 4) {
                            
                            Text(product.title)
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                                .font(.system(size: 20, weight: .regular))
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .layoutPriority(1)
                            
                            if !isMultiline(text: product.title, font: .systemFont(ofSize: 13), maxWidth: 157, maxLines: 2) {
                                Spacer()
                            }
                            
                            Text(stringPrice ?? "")
                                .font(.system(size: 22, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            
                        }
                        
                        Text(product.description)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(.labelsSecondary)
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                }
                
                Button {
                    print("Add to cart clicked!")
                } label: {
                    Text("Add to cart")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.fillsTertiary)
                        )
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                        .padding(.top, 12)
                }
                .background(.backgroundsPrimary)
                
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    func isMultiline(text: String, font: UIFont, maxWidth: CGFloat, maxLines: Int) -> Bool {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let textSize = NSString(string: text).boundingRect(
            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        let lineHeight = font.lineHeight
        return textSize.height > lineHeight * CGFloat(maxLines - 1)
    }
}

//#Preview {
//    ProductDetails(product: ProductModel(id: 2, title: "", description: "", category: "", price: 2.2, discountPercentage: 2.2, thumbnail: ""), _favorites: [Favorite(productID: 2)], toggleFavorite: {})
//}
