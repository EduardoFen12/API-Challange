//
//  ProductListCart.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 13/08/25.
//

import SwiftUI

struct ProductListCart: View {

    var product: ProductModel
    var viewModel: CartViewModel
    var quantity: Int {
        if let cartItem = viewModel.cart.first(where: {
            $0.productID == product.id
        }) {
            return cartItem.quantity
        } else {
            return 0
        }
    }

    var body: some View {

        HStack(spacing: 8) {

            Placeholder(imageStyle: .small)

            HStack(spacing: 16) {

                VStack(spacing: 4) {

                    Text(product.title)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)

                    if !isMultiline(
                        text: product.title,
                        font: .systemFont(ofSize: 13),
                        maxWidth: 157,
                        maxLines: 2
                    ) {
                        Spacer()
                    }

                    Text("US$ \(String(format: "%05.2f", product.price))")
                        .font(.system(size: 17, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
                .frame(width: 157, height: 62)

                HStack(spacing: 0.5) {

                    Button {
                        viewModel.removeFromQuantity(product.id)
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.labelsPrimary)
                            .frame(width: 23, height: 23)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundStyle(.fillsTertiary)

                            )
                    }

                    Text("\(quantity)")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.labelsPrimary)
                        .frame(width: 32)

                    Button {
                        viewModel.addToQuantity(product.id)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.labelsPrimary)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundStyle(.fillsTertiary)
                                    .frame(width: 23, height: 23)
                            )
                    }

                }
                .frame(width: 70, height: 23)

            }
            .padding(8)

        }
        .padding(8)
        .frame(maxWidth: .infinity, minHeight: 94)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.backgroundsSecondary)
        )
        .padding(.leading)
        .padding(.trailing)

    }

    func isMultiline(
        text: String,
        font: UIFont,
        maxWidth: CGFloat,
        maxLines: Int
    ) -> Bool {
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
