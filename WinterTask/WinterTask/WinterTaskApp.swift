//
//  WinterTaskApp.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/23.
//

import SwiftUI
import Foundation

class user: ObservableObject {
    @Published var userName = "User Name"
    @Published var userPhoto: UIImage? = nil
}

var userInfo = user()

func cleanCache() {
    
}

@main
struct WinterTaskApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
