//
//  FileListView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/25.
//

import SwiftUI

struct FileListView: View {
    var file: fileType
    var body: some View {
        HStack {
            Image("icon.\(file.type)")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
            Text(file.name)
            Spacer()
        }
    }
}

var testFile = fileType(name: "test.doc", type: "doc")
struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView(file: testFile)
            .previewLayout(.fixed(width: 300, height: 50))
    }
}
