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
        NavigationStack {
            content
                .navigationTitle("Home")
                .task {
                    if case .idle = viewModel.state {
                        await viewModel.loadProducts()
                    }
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .loading:
            ProgressView()
            
        case .error(let message):
            
            VStack(spacing: 12) {
                Text(message)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("Tentar novamente") {
                    Task { await viewModel.loadProducts() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case .loaded(let deal, let products):
            ScrollView {
                VStack(spacing: 16) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deals of the day")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ProductCardLarge(product: deal)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Top picks")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ForEach(0..<(products.count)/2) { index in
                            HStack(spacing: 8) {
                                    ProductCardMedium(
                                        product: products[2*index],
                                        toggleFavorite: viewModel.toggleFavorite)
                                    ProductCardMedium(
                                        product: products[2*index+1],
                                        toggleFavorite: viewModel.toggleFavorite)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    TabBar()
}
