//
//  Categories.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct CategoriesView: View {
    
    let viewModel: CategoriesViewModel
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Home")
                .task {
                    if case .idle = viewModel.state {
                        await viewModel.loadCategories()
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
                    Task { await viewModel.loadCategories() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .loaded(let allCategories):
            ScrollView {
                ScrollView(.horizontal)
                {
                    HStack(spacing:8) {
                        ForEach(allCategories, id: \.name) { category in
                            
                            CategoriesCard(category: category)
                            
                        }
                        
                    }
                    .padding(.top, 16)
                }
                
                ForEach(allCategories, id: \.name) { category in
                    CategorieListItem(category: category)

                        Divider()
                        .padding(.leading, 16)
                        .frame(height: 1)
                        .padding(.vertical, 0)
                }
                
                
            }
            .navigationTitle("Categories")
            .searchable(text: $searchText)
        }
    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 16) {
//                ScrollView {
//                    HStack(spacing:8) {
//                        ForEach(viewModel.categories) { category in
//                            
//                            CategoriesCard(category: category)
//                            
//                        }
//                        
//                    }
//                    .padding(.top, 16)
//                    
//                    ForEach(viewModel.categories) { category in
//                        CategorieListItem(category: category)
//
//                            Divider()
//                            .padding(.leading, 16)
//                            .frame(height: 1)
//                                    .padding(.vertical, 0)
//                    }
//                    
//                    
//                }
//                .navigationTitle("Categories")
//                .searchable(text: $searchText)
//                
//                
//                
//            }
//        }
//        .task {
//            await viewModel.loadCategories()
//        }
    }
}

#Preview {
    TabBar()
}

