//
//  HomeView.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.

import SwiftUI

struct HomeView: View {
    
    //nao devia estar aqui mas tudo bem
    @Environment(\.modelContext) var context
    
    //itens de navegação podem estar aqui
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
                    ProductDetailsView(product: productNavigation,
                                       viewModel: ProductDetailViewModel(storeService: StorePersistenceService(context: context)), favorites: viewModel.favorites,
                                       toggleFavorite: {viewModel.storeFavorites.toggleFavorite(productNavigation.id)})
                    .onDisappear {
                         viewModel.getFavorites()
                    }
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
            
        case .error:
            
            VStack(spacing: 12) {
                Text(viewModel.errorMessage)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("Tentar novamente") {
                    Task { await viewModel.loadProducts() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case .loaded:
            ScrollView {
                VStack(spacing: 16) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Deals of the day")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        ProductCardLarge(isFavorite: viewModel.isFavorite(viewModel.dealOfDay.id),
                                         toggleFavorite: { viewModel.toggleFavorite(viewModel.dealOfDay.id) },
                                         product: viewModel.dealOfDay)
                            .onTapGesture {
                                productNavigation = viewModel.dealOfDay
                                showDetails = true
                            }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Top picks")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            LazyVGrid(columns: [GridItem(), GridItem()]) {
                                
                                ForEach(viewModel.products){ product in
                                    ProductCardMedium(favorites: viewModel.favorites, isFavorite: viewModel.isFavorite(product.id), toggleFavorite: {viewModel.toggleFavorite(product.id)}, product: product)
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

