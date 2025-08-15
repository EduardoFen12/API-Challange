//
//  EmptyState.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct EmptyState: View {
    
    enum Style {
        case cart
        case favorites
        case orders
        
        var imageName: String {
            switch self {
            case .cart:
                return "cart.badge.questionmark"
            case .favorites:
                return "heart.slash"
            case .orders:
                return "bag.badge.questionmark"
            }
        }

        var title: String {
            switch self {
            case .cart:
                return "Your cart is empty!"
            case .favorites:
                return "No favorites yet!"
            case .orders:
                return "No orders yet!"
            }
        }
        
        var subTitle: String {
            switch self {
            case .cart:
                return "Add an item to your cart."
            case .favorites:
                return "Favorite an item and it will show up here."
            case .orders:
                return "Buy an item and it will show up here."
            }
        }
        
    }
    
    var style: Style
    
    var body: some View {
        
        VStack(spacing: 32) {
            
            VStack(spacing: 8) {
                                
                Image(systemName: style.imageName)
                    .font(.system(size: 48, weight: .medium))
                    .foregroundStyle(.graysGray2)
                                
                VStack(spacing: 16) {
                    Text(style.title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.labelsPrimary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity)
                    
                    Text(style.subTitle)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.labelsSecondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
    
}

#Preview {
    EmptyState(style: .orders)
}
