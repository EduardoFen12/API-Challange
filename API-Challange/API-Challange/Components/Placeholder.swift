//
//  Placeholder.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 14/08/25.
//

import SwiftUI

struct Placeholder: View {
    
    enum ImageStyle {
        case small
        case medium
        case large
        
        var imageName: String {
            switch self {
            case .small:
                return "placeHolderSmall"
            case .medium:
                return "placeHolderMedium"
            case .large:
                return "placeHolderLarge"
            }
        }
        
    }
    
    var imageStyle: ImageStyle
    
    var body: some View {
        
        Image(imageStyle.imageName)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.fillsQuaternary)
            )
        
        
    }
}

#Preview {
    Placeholder(imageStyle: .large)
}
