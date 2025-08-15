//
//  ProductDetails.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 15/08/25.
//

import SwiftUI

struct ProductDetailsView: View {
    var body: some View {
        
        NavigationStack {
                
                Divider()
                
                ScrollView() {
                    
                    VStack(spacing: 16){
                        Placeholder(imageStyle: .large)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 32).fill(.backgroundsSecondary))
                            .overlay(alignment: .topTrailing) {
                                Image(systemName: "heart")
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))
                                    .padding(16)
                                
                            }
                            .padding(.top, 16)
                        
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text("Name of a product with two or more lines goes here")
                                .foregroundStyle(.labelsPrimary)
                                .font(.system(size: 20))
                            
                            Text("R$ 00,00")
                                .foregroundStyle(.labelsPrimary)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                        }
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis nec mauris ac placerat. Cras pulvinar dolor at orci semper hendrerit. Nam elementum leo vitae quam commodo, blandit ultricies diam malesuada. Suspendisse lacinia euismod quam interdum mollis. Pellentesque a eleifend ante. Aliquam tempus ultricies velit, eget consequat magna volutpat vitae. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris pulvinar vestibulum congue. Aliquam et magna ultrices justo condimentum varius.")
                            .font(.body)
                            .foregroundStyle(.labelsSecondary)
                    }

                
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 16)
            .safeAreaInset(edge: .bottom) {
                
                Rectangle()
                    .fill(.backgroundsPrimary)
                    .frame(height: 86)
                    .overlay {
                        Button {
                            //action
                        } label: {
                            Text("Add to cart")
                                .padding(.vertical, 16)
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .foregroundStyle(.labelsPrimary)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 16).fill(.fillsTertiary))
                                .padding(.horizontal, 16)
                        }
                    }
                
            }
            .ignoresSafeArea(edges: .bottom)
            
        }
    }
}

#Preview {
    ProductDetailsView()
}
