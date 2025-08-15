//
//  heartEmpty.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct Unfavorite: View {
    var body: some View {
        Image(systemName: "heart")
            .font(.system(size: 20, weight: .regular))
            .padding(8)
        .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))    }
}

#Preview {
    Unfavorite()
}
