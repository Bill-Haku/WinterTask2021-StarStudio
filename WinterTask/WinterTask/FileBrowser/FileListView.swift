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
            Image("icon\(file.type)")
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
            Text(file.name)
                .font(.title3)
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
            })
        }
    }
}

var testFile = fileType(name: "test.doc", type: ".doc", fileType: 2, readable: true)

struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView(file: testFile, id: 0)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
