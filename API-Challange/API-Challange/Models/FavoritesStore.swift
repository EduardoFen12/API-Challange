//
//  FavoritesStore.swift
//  API-Challange
//
//  Created by Gustavo Ferreira bassani on 16/08/25.
//
import Foundation
import Observation
import SwiftData

//@Observable
//final class FavoritesStore {
//    var ids: Set<Int> = []
//    func favsAddAndRemove(_ id: Int) {
//        if ids.contains(id) {
//            ids.remove(id)
//        } else {
//            ids.insert(id)
//        }
//    }
//}

@Model
final class Favorite {
    @Attribute(.unique) var productID: Int
    init(productID: Int) { self.productID = productID }
}

//
//import SwiftUI
//
//struct Favorite: View {
//    var body: some View {
//        
//        Image(systemName: "heart.fill")
//            .frame(width: 22)
//            .padding(8)
//            .background(RoundedRectangle(cornerRadius: 8).fill(.fillsTertiary))
//    }
//}
//
//#Preview {
//    Favorite()
//}
