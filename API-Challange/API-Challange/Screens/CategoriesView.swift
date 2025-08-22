//
//  Categories.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct CategoriesView: View {
    
    //nao deveria estar aqui mas tudo bem 
    @Environment(\.modelContext) private var context
    
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
                    Task { await viewModel.loadCategories() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .loaded:
            HStack(spacing:8) {
                ForEach(viewModel.fourRandomCategories, id: \.name) { category in
                    
                    NavigationLink (destination: Categories1View(
                        category: category,
                        viewModel: Categories1ViewModel(serviceAPI: ProductAPIService(), serviceFavorites: StorePersistenceService(context: context))
                    )
                    ) {
                        CategoriesCard(category: category)
                    }
                    
                }
                
            }
            .padding(.top, 16)
            ScrollView {
                ForEach(viewModel.allCategories, id: \.name) { category in
                    NavigationLink (destination: Categories1View(category: category, viewModel: Categories1ViewModel(serviceAPI: ProductAPIService(), serviceFavorites: StorePersistenceService(context: context)))){
                        CategorieListItem(category: category)
                    }
                                    
                    Divider()
                        .padding(.leading, 16)
                        .frame(height: 1)
                        .padding(.vertical, 0)
                }
            }
            .navigationTitle("Categories")
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                Task{
                    await viewModel.loadCategories()
                    viewModel.search(by: searchText)
                }
            }
        }
        
    }
}

#Preview {
    TabBar()
}

