//
//  SwiftUIView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct CategoriesCard: View {
    var category: CategoryModel
    var productCategory: ProductCategory {
        ProductCategory(rawValue: category.name) ?? .beauty
    }
    
    var body: some View {
        
        VStack(spacing: 8){
            
            CategoriesImage(systemName: productCategory)
                .frame(width: 84, height: 84)
                .font(.system(size: 32))
                .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
            
            
            Text(category.name)
                .font(.subheadline)
                .foregroundStyle(.labelsPrimary)
                .lineLimit(1)
        }
        .frame(maxWidth: 84)
        
    }
} 

#Preview {
    CategoriesCard(category: CategoryModel(slug: "fragrances", name: "Fragrances", url: "https://dummyjson.com/products/category/fragrances"))
}
