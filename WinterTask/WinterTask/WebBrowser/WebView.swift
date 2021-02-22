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
    @State private var curURL:String = "https://www.apple.com/cn"
    var body: some View {
        return VStack {
            HStack {
                Button(action: {
                    self.urlStr = "https://"
                    self.urlStr = curURL
                    self.urlStrIn = curURL
                }, label: {
                    Image(systemName: "arrow.clockwise")
                })
                TextField("URL", text: $urlStrIn)
                    .frame(width: 300, height: 40, alignment: .center)
                    .border(Color.black, width: 2)
                    .cornerRadius(5)
                Button(action: {
                    self.urlStr = urlStrIn
                    self.curURL = urlStrIn
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
