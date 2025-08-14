//
//  HomeView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        NavigationStack{
            ScrollView() {
                
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deals of the day")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ProductCardLarge()
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Top picks")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack {
                            HStack(spacing: 8) {
                                ProductCardMedium()
                                ProductCardMedium()
                            }
                            
                            HStack(spacing: 8) {
                                ProductCardMedium()
                                ProductCardMedium()
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    TabBar()
}
