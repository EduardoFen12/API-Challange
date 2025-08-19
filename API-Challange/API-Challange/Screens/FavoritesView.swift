//
//  Favorites.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    

    @State private var showCartSheet = false
    @State private var searchText = ""

    var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Favorites")
                .searchable(text: $searchText)
                .sheet(isPresented: $showCartSheet, content: {
                    DetailView(name: "oi", price: 4.4, description: "oi")
                })
                .task {
//                    if case .idle = viewModel.state {
                    await viewModel.loadingFavorites()
                    await viewModel.getFavoriteProducts()
                    
//                    }
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
            
            
        case .loaded:
            VStack(spacing: 16) {
                VStack {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.favoriteProducts) { fav in
                                Button {
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
