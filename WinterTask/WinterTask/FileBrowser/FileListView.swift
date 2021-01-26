//
//  FileListView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/25.
//

import SwiftUI

struct FileListView: View {
    var fileType: String
    var fileName: String
    var body: some View {
        HStack {
            Image(systemName: fileType)
            Text(fileName)
            Spacer()
        }
    }
}

struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView(fileType: "doc", fileName: "Test.pdf")
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
