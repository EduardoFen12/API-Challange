//
//  TabBar.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
        }
        
    }
}

#Preview {
    TabBar()
}
