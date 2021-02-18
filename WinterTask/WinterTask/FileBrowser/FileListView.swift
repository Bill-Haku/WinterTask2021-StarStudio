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
    @State private var remoteImage : UIImage? = nil
    let placeholderOne = UIImage(named: "GirlInside")
    var body: some View {
        HStack {
            if ((file.fileType == 2) || (file.fileType == 3)) {
                Image("icon\(file.type)")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
            }
            else if file.fileType == 1 {
                Image(uiImage: self.remoteImage ?? placeholderOne!)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(7)
                    .onAppear(perform: fetchRemoteImage)
            }
            else {
                if file.name != "" {
                    Image(systemName: "questionmark.square.dashed")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
            }
            Text(file.name)
                .font(.title3)
            Spacer()
            if file.name != "" {
                Button(action: {
                    /*var indexPath: NSIndexPath
                    let document = UIDocumentInteractionController(url: file.url)
                    let rect = self.tableView.rectForRowAtIndexPath(indexPath)
                    document.presentOpenInMenuFromRect(rect, inView: self.tableView, animated: true)*/
                    //let document = UIDocumentInteractionController(url: file.url)
                    //document.presentOpenInMenu(from: Button(), animated: true)
                    //let url = file.url
                    //let documentController = UIDocumentInteractionController(url: url)
                    //documentController?.presentOptionsMenu(from: self.body.bounds, in: self.body, animated: true)
                }, label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                })
            }
        }
    }
    
    func fetchRemoteImage() {
        guard let url = URL(string: file.url.absoluteString) else { return }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let image = UIImage(data: data!){
                self.remoteImage = image
            }
            else{
                print(error ?? "")
            }
        }.resume()
    }
}

var testFile = fileType(name: "test.doc", type: ".doc", fileType: 2, readable: true, url:emptyURL)

struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView(file: testFile, id: 0)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
