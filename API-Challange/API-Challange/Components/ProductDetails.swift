//
//  ProductDetails.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 15/08/25.
//

import SwiftUI

struct ProductDetails: View {
    
    var name: String
    var price: Double
    var description: String
    
    var body: some View {
        
        VStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    
                    Placeholder(imageStyle: .large)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(alignment: .topTrailing) {
                            Image(systemName: "heart")
                                .font(.system(size: 28))
                                .frame(width: 34, height: 34)
                                .padding(8)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.graysGray5))
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 32).fill(.backgroundsSecondary))
                    
                    VStack(spacing: 4) {
                        
                        Text(name)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .layoutPriority(1)
                        
                        if !isMultiline(text: name, font: .systemFont(ofSize: 13), maxWidth: 157, maxLines: 2) {
                                        Spacer()
                                    }
                        
                        Text("US$ \(String(format: "%05.2f", price))")
                            .font(.system(size: 22, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                    .frame(width: .infinity, height: 82)
                    
                    Text(description)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.labelsSecondary)
                }
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom)
            }
                
            Button {
                print("Add to cart clicked!")
            } label: {
                Text("Add to cart")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.labelsPrimary)
                    .frame(maxWidth: .infinity, minHeight: 54, maxHeight: 54)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(.fillsTertiary)
                    )
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                    .padding(.top, 12)
            }
            .background(.backgroundsPrimary)
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    func isMultiline(text: String, font: UIFont, maxWidth: CGFloat, maxLines: Int) -> Bool {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let textSize = NSString(string: text).boundingRect(
            with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: attributes,
            context: nil
        )
        let lineHeight = font.lineHeight
        return textSize.height > lineHeight * CGFloat(maxLines - 1)
    }
}

#Preview {
    ProductDetails(name: "Name of a product with two or more lines goes here", price: 0, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lobortis nec mauris ac placerat. Cras pulvinar dolor at orci semper hendrerit. Nam elementum leo vitae quam commodo, blandit ultricies diam malesuada. Suspendisse lacinia euismod quam interdum mollis. Pellentesque a eleifend ante. Aliquam tempus ultricies velit, eget consequat magna volutpat vitae. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris pulvinar vestibulum congue. Aliquam et magna ultrices justo condimentum varius.")
}
