//
//  PDFReader.swift
//  WinterTask
//
//  Created by HakuBill on 2021/02/04.
//

import SwiftUI
import PDFKit

struct PDFReader: View {
    var file: fileType
    var body: some View {
        PDFKitRepresentedView(file.url)
            .navigationBarTitle(Text(file.name))
    }
}

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL
    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {
        // Update the view.
    }
}

struct PDFReader_Previews: PreviewProvider {
    static var previews: some View {
        PDFReader(file: testFile)
    }
}
