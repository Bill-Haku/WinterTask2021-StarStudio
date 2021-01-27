//
//  WebView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/26.
//

import SwiftUI
import WebKit

struct WebView: View {
    @State private var urlStrIn: String = "https://www.apple.com/cn"
    @State private var urlStr: String = "https://www.apple.com/cn"
    var body: some View {
        return VStack {
            HStack {
                TextField("URL", text: $urlStrIn)
                    .frame(width: 310, height: 40, alignment: .center)
                    .border(Color.black, width: 2)
                    .cornerRadius(5)
                Button(action: {
                    self.urlStr = urlStrIn
                }, label: {
                    Text("Go")
                })
            }
            .padding()
            SwiftUIWKWebView(url: urlStr)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
