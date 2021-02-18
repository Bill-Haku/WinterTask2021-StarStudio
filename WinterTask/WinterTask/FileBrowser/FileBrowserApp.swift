//
//  FileBrowserApp.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/25.
//

import Foundation
import UIKit
import SwiftUI

var homePath = NSHomeDirectory()
var documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
var libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
var tmpPath = NSTemporaryDirectory()

var fileManager = FileManager.default

func createFolderIfNotExisits(folderPath : String)->Bool {
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString    //get sandbox path
    let fileManager = FileManager.default
    let filePath = documentPath as String + "/" + folderPath
    let exist = fileManager.fileExists(atPath: filePath)
    if !exist {
        try! fileManager.createDirectory(atPath: filePath,withIntermediateDirectories: true, attributes: nil)
    }
    return exist
}

func createNewFolder(folderName: String) {
    let fileManager = FileManager.default
    let documentsDirectory =  try? FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
}

func getAllFileName(folderPath: String)->[String]{
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    let manager = FileManager.default
    let fileUrl = documentPath as String + "/" + folderPath
    let subPaths = manager.subpaths(atPath: fileUrl)
    let array = subPaths?.filter({$0 != ".DS_Store"})
    return array!
}

func deleteFile(folderPath: String, fileName: String) -> Bool{
    var success = false
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    let manager = FileManager.default
    let fileUrl = documentPath as String + "/" + folderPath
    let subPaths = manager.subpaths(atPath: fileUrl)
    let removePath = fileUrl + "/" + fileName
    for fileStr in subPaths!{
        if fileName == fileStr {
            try! manager.removeItem(atPath: removePath)
            success = true
        }
    }
    return success
}

func openICloudDrive(folderUrl : String, folderName : String) {
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    let manager = FileManager.default
    let fileManager = FileManager.default
    let filePath = documentPath as String + "/" + folderUrl
    let exist = fileManager.fileExists(atPath: filePath)
    if !exist {
        try! fileManager.createDirectory(atPath: filePath,withIntermediateDirectories: true, attributes: nil)
    }
    let createFilePath = filePath + "/" + folderName
    if manager.fileExists(atPath: createFilePath) {
        print("This path has the file of the same name, file create fail.")
    }
    else {
        let urlStr = ""
        let data = urlStr.data(using: String.Encoding.utf8)
        let isSuccess = manager.createFile(atPath: createFilePath, contents: data!, attributes: nil)
        print(isSuccess ? "File Create Success" : "File Create Fail")
    }
}

class fileType: Identifiable {
    var name: String
    var type: String
    var fileType: Int
    var readable: Bool
    /*
     fileType 1: photos
     fileType 2: documents
     fileType 3: pdf
     fileType 4: others
     */
    var url: URL
    init (name: String, type: String, fileType: Int, readable: Bool, url: URL) {
        self.name = name
        self.type = type
        self.fileType = fileType
        self.readable = readable
        self.url = url
    }
}

let emptyPath: String = String(format: "file///")
let emptyURL: URL = URL(string: emptyPath)!
/*var fileList0 = fileType(name: "test1.docx", type: ".docx", fileType: 2, readable: true)
var fileList1 = fileType(name: "test2.pdf", type: ".pdf", fileType: 3, readable: true)
var fileList2 = fileType(name: "test3.xml", type: ".xml", fileType: 4, readable: false)*/
var fileListEmpty = fileType(name: "", type: "",fileType: 4, readable: false, url: emptyURL)
var fileListArray: [fileType] = [fileListEmpty]
//var fileListArrayTest: [fileType] = [fileList0, fileList1, fileList2]

extension String {
    var `extension`: String {
        if let index = self.lastIndex(of: ".") {
            return String(self[index...])
        } else {
            return ""
        }
    }
}

func getFileList() {
    guard let documentsDirectory =  try? FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
    guard let fileEnumerator = FileManager.default.enumerator(at: documentsDirectory, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions()) else { return }
    while let file = fileEnumerator.nextObject() {
        let newFileCLass = fileType(name: "", type: "",fileType: 4,readable: false, url: file as! URL)
        let fileNameURL = file as! NSURL
        let fileNameStr = fileNameURL.lastPathComponent
        let fileType = fileNameStr?.extension
        newFileCLass.name = fileNameStr ?? "Fail"
        newFileCLass.type = fileType ?? "Fail"
        newFileCLass.url = fileNameURL as URL
        if ((newFileCLass.type == ".jpg") || (newFileCLass.type == ".png") || (newFileCLass.type == ".JPG") || (newFileCLass.type == ".PNG")) {
            newFileCLass.fileType = 1
            newFileCLass.readable = true
        }
        else if ((newFileCLass.type == ".docx") || (newFileCLass.type == ".doc")) {
            newFileCLass.fileType = 2
            newFileCLass.readable = true
        }
        else if newFileCLass.type == ".pdf" {
            newFileCLass.fileType = 3
            newFileCLass.readable = true
        }
        else {
            newFileCLass.fileType = 4
            newFileCLass.readable = false
        }
        print(file)
        print(newFileCLass.name)
        print(newFileCLass.type)
        fileListArray.append(newFileCLass)
    }
}
func refreshFileList() {
    fileListArray.removeAll()
    getFileList()
    print("refreshing")
}

// MARK: - 其他app分享过来时回调
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
  print("openURLContexts:\(URLContexts)")
    // 获取 Document/Inbox 里从其他app分享过来的文件
    let manager = FileManager.default
    let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
    var documentUrl = urlForDocument[0] as URL
    documentUrl.appendPathComponent("Inbox", isDirectory: true)
    do {
      let contentsOfPath = try manager.contentsOfDirectory(at: documentUrl,
                                                           includingPropertiesForKeys: nil,
                                                           options: .skipsHiddenFiles)
      //self.url = contentsOfPath.first // 保存，为了展示分享
      print("contentsOfPath:\n\(contentsOfPath)")
    } catch {
      print("error:\(error)")
    }


}

// MARK: - Add an alert with TextField
extension UIAlertController {
    convenience init(alert: TextAlert) {
        self.init(title: alert.title, message: nil, preferredStyle: .alert)
        addTextField{ $0.text = alert.value}
        addAction(UIAlertAction(title: alert.cancel, style: .cancel) { _ in
            alert.action(nil)
        })
        let textField = self.textFields?.first
        addAction(UIAlertAction(title: alert.accept, style: .default){ _ in
            alert.action(textField?.text)
        })
    }
}

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: TextAlert
    let content: Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }
    
    final class Coordinator {
        var alertController: UIAlertController?
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
        uiViewController.rootView = content
        if isPresented && uiViewController.presentedViewController == nil {
            var alert = self.alert
            alert.action = {
                self.isPresented = false
                self.alert.action($0)
            }
            context.coordinator.alertController = UIAlertController(alert: alert)
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }
        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }
}

public struct TextAlert {
    public var title: String
    public var value: String = ""
    public var placeholder: String = ""
    public var accept: String = "OK"
    public var cancel: String = "Cancel"
    public var action: (String?) -> ()
}

extension View {
    public func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
        AlertWrapper(isPresented: isPresented, alert: alert, content: self)
    }
}
