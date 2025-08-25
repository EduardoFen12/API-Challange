//
//  TabBar.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {

    @State private var selectedTab = 0

    @Environment(\.modelContext) private var context
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            
            HomeView(viewModel: HomeViewModel(serviceAPI: ProductAPIService(),
                                              storeFavorites: StorePersistenceService(context: context)))
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
                    .accessibilityLabel("Home")
            }
            .tag(0)
            
            CategoriesView(viewModel: CategoriesViewModel(service: ProductAPIService()))
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Categories")
                        .accessibilityLabel("Categories")

                }
                .tag(1)
            
            CartView(viewModel: CartViewModel(serviceAPI: ProductAPIService(), serviceStore: StorePersistenceService(context: context)))
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                        .accessibilityLabel("Cart")

                }
                .tag(2)
            
            FavoritesView(viewModel: FavoritesViewModel(serviceAPI: ProductAPIService(), storeFavorites: StorePersistenceService(context: context)))
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
                    .accessibilityLabel("Favorites")

            }
            .tag(3)
            
            OrdersView(viewModel: OrdersViewModel(storeService: StorePersistenceService(context: context)))
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Orders")
                        .accessibilityLabel("Orders")

                }
                .tag(4)
        }
        
        
    }
}

#Preview {
    TabBar()
}
