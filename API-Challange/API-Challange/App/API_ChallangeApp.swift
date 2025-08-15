//
//  API_ChallangeApp.swift
//  API-Challange
//
//  Created by Eduardo Garcia Fensterseifer on 13/08/25.
//

import SwiftUI
import SwiftData

@main
struct API_ChallangeApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(for: [ProductModel.self, CategoryModel.self])
    }
}

