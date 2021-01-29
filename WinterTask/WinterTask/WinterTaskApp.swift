//
//  WinterTaskApp.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/23.
//

import SwiftUI
class user: ObservableObject {
    @Published var userName = "User Name"
}

var userInfo = user()

@main
struct WinterTaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
