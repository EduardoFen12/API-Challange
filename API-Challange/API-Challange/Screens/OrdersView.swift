//
//  OrdersView.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI

struct OrdersView: View {
    
    @State private var searchText = ""
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var viewModel: OrdersViewModel
    var isIpad: Bool { verticalSizeClass == .regular }
    
    var body: some View {
        NavigationStack {
            content
                .task {
                    await viewModel.loadView()
                }
//                .padding(.bottom)
                .navigationTitle("Orders")
                .searchable(text: $searchText)
                .onChange(of: searchText) {
                    Task{
                        await viewModel.loadView()
                        viewModel.search(by: searchText)
                    }
                }
            
        }
    }
    
    
    @ViewBuilder
    var content: some View {
        VStack(spacing: 16) {
            
            switch viewModel.state {
            case .idle:
                Color.clear
            case .loading:
                ProgressView()
            case .isEmpty:
                EmptyState(style: .orders)
            case .loaded:
                VStack {
                    ScrollView {
                        if isIpad {
                            ViewThatFits{
                                //Horizontal
                                VStack (spacing: 16) {
                                    ForEach(viewModel.orders) { productOrder in
                                        ProductListDelivery(productName: productOrder.title, price: productOrder.price, date: productOrder.date , image: productOrder.image, padding: 261, isIpad: isIpad)
                                    }
                                }
                                //Vertical
                                VStack (spacing: 16) {
                                    ForEach(viewModel.orders) { productOrder in
                                        ProductListDelivery(productName: productOrder.title, price: productOrder.price, date: productOrder.date , image: productOrder.image, padding: 130, isIpad: isIpad)
                                    }
                                }
                            }
                        } else {
                            VStack (spacing: 16) {
                                ForEach(viewModel.orders) { productOrder in
                                    ProductListDelivery(productName: productOrder.title, price: productOrder.price, date: productOrder.date , image: productOrder.image)
                                        .accessibilityLabel("Order of \(productOrder.title), will be \(getMonth(from: productOrder.date, isVoiceOver: true) ?? "deliverd by month 00"), and costed \(productOrder.price)")
                                }
                            }
                        }
                    }
                }
                .padding(.top, isIpad ? 16 : 0)
                
            case .error:
                VStack(spacing: 12) {
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button("Tentar novamente") {
                        Task { await viewModel.loadView() }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
        }
    }
    func getMonth(from dateString: String, isVoiceOver: Bool = false) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: dateString) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM"
        
        return isVoiceOver ? "delivered by month \(outputFormatter.string(from: date))" : "DELIVERY BY MONTH, \(outputFormatter.string(from: date))"
    }
}

#Preview {
    TabBar()
}
