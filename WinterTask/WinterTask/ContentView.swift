//
//  ContentView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FileManagementView()
                .tabItem {
                    Image(systemName: "folder")
                    Text("Files")
                }
            WebView()
                .tabItem {
                    Image(systemName: "network")
                    Text("Internet")
                }
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            UserInfoView()
                .tabItem {
                    Image(systemName: "person")
                    Text("User")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
