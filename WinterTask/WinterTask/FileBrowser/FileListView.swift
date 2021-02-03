//
//  FileListView.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/25.
//

import SwiftUI

struct FileListView: View {
    var file: fileType
    var id: Int
    var body: some View {
        HStack {
            Image("icon\(fileListArray[id].type)")
                .resizable()
                .frame(width: 60, height: 60, alignment: .center)
            Text(fileListArray[id].name)
                .font(.title)
            Spacer()
            Text("\(id)")
        }
    }
}

var testFile = fileType(name: "test.doc", type: "doc")
struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView(file: testFile, id: 0)
            .previewLayout(.fixed(width: 300, height: 80))
    }
}
