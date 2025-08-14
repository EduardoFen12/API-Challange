//
//  HeartFilled.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

struct Favorite: View {
    var body: some View {
        
        Image(systemName: "heart.fill")
            .frame(width: 22)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))
    }
}

#Preview {
    Favorite()
}
