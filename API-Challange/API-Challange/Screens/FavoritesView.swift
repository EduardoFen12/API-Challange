//
//  Favorites.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @Environment(\.modelContext) var context

    @State private var showCartSheet = false
    @State private var searchText = ""
    @State private var productNavigation: ProductModel = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")

    @State var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Favorites")
                .searchable(text: $searchText)
                .sheet(isPresented: $showCartSheet, content: {
                    ProductDetailsView(product: productNavigation, viewModel: ProductDetailViewModel(storeService: StorePersistenceService(context: context)), toggleFavorite: {viewModel.serviceFavorites.toggleFavorite(productNavigation.id)})
                    .onDisappear {
                        Task {
                            
                            await viewModel.loadingFavorites()
                            await viewModel.getFavoriteProducts()
                        }
                    }
                })
                .task {
                    await viewModel.loadingFavorites()
                    await viewModel.getFavoriteProducts()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
                .onAppear {
                    print("passou pelo idle")

                }

        case .isLoading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .onAppear {
                    print("passou pelo isloading")
                }
            
        case .error(let message):
            VStack(spacing: 12) {
                Text(message)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("Tentar novamente") {
                    Task { await viewModel.loadingFavorites() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            
        case .loaded(let favoriteProducts):
            VStack(spacing: 16) {
                VStack {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(favoriteProducts) { fav in
                                Button {
                                    productNavigation = fav
                                    showCartSheet = true
                                } label: {
                                    ProductListFavorites(product: fav)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
            
        case .favsEmpty:
            EmptyState(style: .favorites)
        }
    }
}


#Preview {
    TabBar()
}
