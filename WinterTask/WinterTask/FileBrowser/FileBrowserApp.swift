//
//  FileBrowserApp.swift
//  WinterTask
//
//  Created by HakuBill on 2021/01/25.
//

import Foundation

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
