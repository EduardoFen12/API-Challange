//
//  Categories.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct CategoriesView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ScrollView {
                    HStack(spacing:8) {
                        ForEach(1..<5) { index in
                            
                            CategoriesCard(number: index)
                            
                        }
                        
                    }
                    .padding(.top, 16)
                    
                    ForEach(1..<8) { index in
                        CategorieListItem(number: index)

                            Divider()
                            .padding(.leading, 16)
                            .frame(height: 1)
                                    .padding(.vertical, 0)
                    }
                    
                    
                }
                .navigationTitle("Categories")
                .searchable(text: $searchText)
                
                
                
            }
        }
    }
}

#Preview {
    TabBar()
}

