//
//  TabBar.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
 
    @State private var selectedTab = 3
    @Environment(\.modelContext) private var context
    
    @State var favoritesViewModel: FavoritesViewModel?

    var body: some View {
        TabView(selection: $selectedTab) {
            
            if let favoritesViewModel {
                HomeView(viewModel: HomeViewModel(serviceAPI: ProductAPIService(context: context), serviceFavorites: ProductFavoriteService(context: context)))
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                
                CategoriesView(viewModel: CategoriesViewModel(service: ProductAPIService(context: context)))
                    .tabItem {
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Categories")
                    }
                    .tag(1)

                CartView()
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }
                    .tag(2)
                
                FavoritesView(viewModel: favoritesViewModel)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favorites")
                    }
                    .tag(3)
                
                OrdersView()
                    .tabItem {
                        Image(systemName: "bag.fill")
                        Text("Orders")
                    }
                    .tag(4)
            }
           
        }
        .onAppear {
            favoritesViewModel = FavoritesViewModel(serviceAPI: ProductAPIService(context: context), serviceFavorites: ProductFavoriteService(context: context))
        }
        
    }
}

#Preview {
    TabBar()
}
