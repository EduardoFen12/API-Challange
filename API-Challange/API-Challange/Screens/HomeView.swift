//
//  HomeView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct HomeView: View {
    
    let viewModel: HomeViewModel
    @State var showDetails = false
    @State var productNavigation: ProductModel = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Home")
                .task {
                    await viewModel.loadProducts()
                }
                .sheet(isPresented: $showDetails, content: {
                    ProductDetailsView(product: productNavigation, toggleFavorite: {viewModel.serviceFavorites.toggleFavorite(productNavigation.id)})
                })
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
                        
                        ProductCardLarge(toggleFavorite: { viewModel.toggleFavorites(deal.id) }, product: deal)
                            .onTapGesture {
                                productNavigation = deal
                                showDetails = true
                            }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Top picks")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            LazyVGrid(columns: [GridItem(), GridItem()]) {
                                
                                ForEach(products){ product in
                                    ProductCardMedium(
                                        toggleFavorite: { viewModel.toggleFavorites(product.id)},
                                        product: product)
                                    .onTapGesture {
                                        productNavigation = product
                                        showDetails = true
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
#Preview {
    TabBar()
}

