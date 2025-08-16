//
//  Categorie1View.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI

struct Categories1View: View {
    
    @State private var searchText = ""

    var body: some View {
        
        NavigationStack{
        
            VStack (spacing: 8) {
                Divider()
                ScrollView {
                    ForEach(1..<4) { _ in
                        HStack  {
                            ForEach (1..<3) { _ in
                                
//                            ProductCardMedium()
                            }
                        }
                        
                    }
                }
                .navigationTitle("Category 1")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText, placement: .navigationBarDrawer)
            }
        }
        
    }
}

#Preview {
    Categories1View()
}

//search bar diferente?? 
