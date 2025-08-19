//
//  Categorie1View.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI

struct Categories1View: View {
    
    let category: CategoryModel
    let viewModel: Categories1ViewModel
    let favoritesViewModel: FavoritesViewModel
    
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
                        ForEach(0..<(filteredProducts.count)/2) { index in
                            HStack  {
                                ProductCardMedium(product: filteredProducts[2*index]) { productID in
                                    //código de toggle
                                }
                                ProductCardMedium(product: filteredProducts[2*index+1]) { productID in
                                    //código de toggle
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

//    var body: some View {
//        
//        NavigationStack{
//        
//            VStack (spacing: 8) {
//                Divider()
//                ScrollView {
//                    ForEach(1..<4) { _ in
//                        HStack  {
//                            ForEach (1..<3) { _ in
//                                
//                            ProductCardMedium()
//                            }
//                        }
//                        
//                    }
//                }
//                .navigationTitle("Category 1")
//                .navigationBarTitleDisplayMode(.inline)
//                .searchable(text: $searchText, placement: .navigationBarDrawer)
//            }
//        }
//        
//    }
}

#Preview {
    TabBar()
}

//search bar diferente?? 
