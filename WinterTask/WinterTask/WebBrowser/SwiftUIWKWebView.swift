//
//  SwiftUIWKWebView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/26.
//

import SwiftUI
import WebKit

struct SwiftUIWKWebView: UIViewRepresentable {
    var url: String
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url)
        else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let webview = WKWebView()
        webview.load(request)
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: self.url) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct SwiftUI_WKWebView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIWKWebView(url: "https://www.apple.com")
            .edgesIgnoringSafeArea(.bottom)
    }
}
