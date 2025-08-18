//
//  CategorieListItem.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct CategorieListItem: View {
    var category: CategoryModel
    
    var body: some View {
        
        HStack {
            Text(category.name)
                .font(.body)
                .foregroundStyle(.labelsPrimary)
                .padding(.leading, 16)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.labelsTertiary)
                .fontWeight(.semibold)
                .padding(.trailing, 16)
                
        }
        .frame(height: 60)
    }
    
}
//
//#Preview {
//    CategorieListItem(category: CategoryModel(name: "Beauty"))
//}
