//
//  FileImageReader.swift
//  WinterTask
//
//  Created by HakuBill on 2021/02/03.
//

import SwiftUI

struct FileImageReader: View {
    var file: fileType
    @State private var remoteImage : UIImage? = nil
    let placeholderOne = UIImage(named: "GirlInside")
        
    var body: some View {
        Image(uiImage: self.remoteImage ?? placeholderOne!)
            .onAppear(perform: fetchRemoteImage)
            .navigationBarTitle(Text(file.name))
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

struct FileImageReader_Previews: PreviewProvider {
    static var previews: some View {
        FileImageReader(file: testFile)
    }
}
