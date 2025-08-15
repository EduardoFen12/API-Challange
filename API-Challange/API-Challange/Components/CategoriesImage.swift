//
//  Categories.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 14/08/25.
//

import SwiftUI

enum CategoriesEnum: String {
    case sparkles = "sparkles"
    case dropFill = "drop.fill"
    case chairLoungeFill = "chair.lounge.fill"
    
    case basketFill = "basket.fill"
    case lampTableFill = "lamp.table.fill"
    case forkKnife = "fork.knife"
    
    case laptopcomputer = "laptopcomputer"
    case tshirtFill = "tshirt.fill"
    case shoeFill = "shoe.fill"
    
    case applewatchface = "applewatch.watchface"
    case powercord = "powercord.fill"
    case moto = "motorcycle.fill"
    
    case faceSmileReverse = "face.smiling.inverse"
    case iphone = "iphone"
    case tennisRacket = "tennis.racket"
    
    case sunglasses = "sunglasses.fill"
    case ipad = "ipad"
    case jacket = "jacket.fill"
    
    case carFill = "car.fill"
    case handBagFill = "handbag.fill"
    case figureDress = "figure.stand.dress"
    
    case crownFill = "crown.fill"
    case shoePrints = "shoeprints.fill"
    case watchAnalog = "watch.analog"
}
struct CategoriesImage: View {
    var systemName: CategoriesEnum
    
    var body: some View {
        Image(systemName: systemName.rawValue)
            .foregroundStyle(.fillsSecondary)
        
    }
}

#Preview {
    CategoriesImage(systemName: .sunglasses)
}
