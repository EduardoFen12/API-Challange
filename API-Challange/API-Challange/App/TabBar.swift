//
//  TabBar.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct TabBar: View {
    // Poem esse selectedTab no numero que tu quer ver, ai no preview tu já põem a tabbar la na tela ao invés de ver a tela fora da tabbar.. 
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            CategoriesView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Categories")
                }
                .tag(1)
            
            
        }
        
    }
}

#Preview {
    TabBar()
}
