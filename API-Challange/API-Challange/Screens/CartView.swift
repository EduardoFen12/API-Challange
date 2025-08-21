//
//  CartView.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI
import SwiftData

struct CartView: View {
    
    let viewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Cart")
                .task {
                    await viewModel.loadCart()
                    await viewModel.getCartProducts()
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
                    Task { await viewModel.loadCart() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case .loaded:
            
            VStack(spacing: 16) {
                VStack {
                    ScrollView {
                        VStack (spacing: 16) {
                            ForEach(viewModel.cartProducts) { product in
                                ProductListCart(product: product, viewModel: viewModel)
                            }
                        }
                    }
                    .padding(.top)
                    
                    VStack {
                        HStack {
                            Text("Total:")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(.labelsPrimary)
                            Spacer()
                            Text("US$ \(viewModel.totalPrice)")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.labelsPrimary)
                        }
                        
                        Button {
                            
                            Task {
                                await viewModel.makeOrder()
                                
                                await MainActor.run {
                                    viewModel.state = .isLoading
                                }
                                
                                await viewModel.loadCart()
//                                viewModel.state = .cartEmpty
                                
//                                await viewModel.getCartProducts()
                            }
                            
                        } label: {
                            Text("Checkout")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.labelsPrimary)
                                .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .foregroundStyle(.fillsTertiary)
                                )
                        }
                        
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                }
            }
                
        case .cartEmpty:
            EmptyState(style: .cart)
            
        }
    }
}

#Preview {
    TabBar()
}
