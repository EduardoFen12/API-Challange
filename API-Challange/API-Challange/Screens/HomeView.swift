//
//  HomeView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    
    let viewModel: HomeViewModel
        
    var body: some View {
        
        NavigationStack{
            
//            if viewModel.isLoading {
//                ProgressView()
//            } else if let errorMessage = viewModel.errorMessage {
//                Text(errorMessage)
//                    .foregroundStyle(.red)
//            } else {
                ScrollView() {
                    
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Deals of the day")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            if let dealPickProduct = viewModel.dealPickProduct {
                                
                                ProductCardLarge(product: dealPickProduct)
                            }
                            
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
                .task {
                    await viewModel.loadProducts()
                }
//            }
        }
    }
}

#Preview {
    TabBar()
}
