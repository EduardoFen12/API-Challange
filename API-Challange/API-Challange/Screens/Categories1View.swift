//
//  Categorie1View.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI
import SwiftData

struct Categories1View: View {

    //nao deveria estar aqui mas tudo bem
    @Environment(\.modelContext) var context
    
    let category: CategoryModel
    let viewModel: Categories1ViewModel
    @State var showDetails = false
    @State private var searchText = ""
    
    //esse é dado de navegação, fica aqui
    @State var productNavigation: ProductModel = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Home")
                .task {
                    if case .idle = viewModel.state {
                        await viewModel.loadProducts(category: category)
                    }
                }
                .sheet(isPresented: $showDetails, content: {
                    ProductDetailsView(favorites: viewModel.favorites, viewModel: ProductDetailViewModel(storeService: StorePersistenceService(context: context), product: productNavigation), toggleFavorite: {viewModel.toggleFavorite(productNavigation.id)})
                })
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            
            ProgressView()
        case .isLoading:
            ProgressView()
        case .error(let message):
            
            VStack(spacing: 12) {
                Text(message)
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button("Tentar novamente") {
                    Task { await viewModel.loadProducts(category: category) }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .loaded:
            NavigationStack{
                
                VStack (spacing: 8) {
                    Divider()
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            
                            ForEach(viewModel.productsFromCategory){ product in
                                ProductCardMedium(favorites: viewModel.favorites, isFavorite: viewModel.isFavorite(product.id), toggleFavorite: {viewModel.toggleFavorite(product.id)}, product: product)
                                .onTapGesture {
                                    productNavigation = product
                                    showDetails = true
                                }
                            }
                        }
                    }
                    .navigationTitle(category.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(text: $searchText, placement: .navigationBarDrawer)
                }
            }
        }
    }
}

#Preview {
    TabBar()
}

