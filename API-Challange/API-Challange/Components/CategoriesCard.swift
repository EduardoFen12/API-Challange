//
//  SwiftUIView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct CategoriesCard: View {
    var body: some View {
        
        VStack(spacing: 8){
            
            CategoriesImage(systemName: .sparkles)
                .frame(width: 84, height: 84)
                .font(.system(size: 32))
                .background(RoundedRectangle(cornerRadius: 16).fill(.backgroundsSecondary))
            
            
            Text("Category 1")
                .font(.subheadline)
                .foregroundStyle(.labelsPrimary)
        }
        
    }
}

#Preview {
    CategoriesCard()
}
