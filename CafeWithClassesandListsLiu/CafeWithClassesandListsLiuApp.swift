//
//  CafeWithClassesandListsLiuApp.swift
//  CafeWithClassesandListsLiu
//
//  Created by ALLEN LIU on 10/2/26.
//

import SwiftUI
import SwiftData

@main
struct CafeWithClassesandListsLiuApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)

    }
}
