//
//  Favorites.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    //nao devia estar aqui mas tudo bem
    @Environment(\.modelContext) var context
    
    //aqui ta ok
    @State private var productNavigation: ProductModel = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")
    @State private var showCartSheet = false
    @State private var searchText = ""

    @State var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Favorites")
                .searchable(text: $searchText)
                .onChange(of: searchText) {
                    Task{
                        await viewModel.loadingFavorites()
                        await viewModel.getFavoriteProducts()
                        viewModel.search(by: searchText)
                    }
                }
                .sheet(isPresented: $showCartSheet, content: {
                    ProductDetailsView(favorites: viewModel.favorites, viewModel: ProductDetailViewModel(storeService: StorePersistenceService(context: context), product: productNavigation), toggleFavorite: {viewModel.toggleFavorite(productNavigation.id)})
                    .onDisappear {
                        Task {
                            
                            await viewModel.loadingFavorites()
                            await viewModel.getFavoriteProducts()

                            viewModel.getFavorites()
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

                }

        case .isLoading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .onAppear {
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
            
            
        case .loaded:
            VStack(spacing: 16) {
                VStack {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.favProducts) { fav in
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
