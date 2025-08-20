//
//  Categorie1View.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI
import SwiftData

struct Categories1View: View {
    
    let category: CategoryModel
    let viewModel: Categories1ViewModel
    @Environment(\.modelContext) var context
    
    @State var showDetails = false
    @State var productNavigation: ProductModel = ProductModel(id: 0, title: "", description: "", category: "", price: 0, discountPercentage: 0, thumbnail: "")
    @State private var searchText = ""


    
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
                    ProductDetailsView(product: productNavigation, viewModel: ProductDetailViewModel(storeService: StorePersistenceService(context: context)), toggleFavorite: {viewModel.serviceFavorites.toggleFavorite(productNavigation.id)})
                })
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            
            Color.clear
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
        case .loaded(let filteredProducts):
            NavigationStack{
                
                VStack (spacing: 8) {
                    Divider()
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            
                            ForEach(filteredProducts){ product in
                                ProductCardMedium(
                                    toggleFavorite: {
                                        viewModel.toggleFavorites(product.id)
                                    }, product: product)
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

