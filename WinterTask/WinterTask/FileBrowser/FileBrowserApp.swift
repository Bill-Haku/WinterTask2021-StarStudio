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
    
    init (name: String, type: String) {
        self.name = name
        self.type = type
    }
}

var fileList0 = fileType(name: "test1.docx", type: ".docx")
var fileList1 = fileType(name: "test2.pdf", type: ".pdf")
var fileList2 = fileType(name: "test3.xml", type: ".xml")
var newFileCLass = fileType(name: "", type: "")
var newArray = fileType(name: "", type: "")
var fileListArray: [fileType] = [fileList0, fileList1, fileList2]

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
    var i = 0
    guard let documentsDirectory =  try? FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return }
    guard let fileEnumerator = FileManager.default.enumerator(at: documentsDirectory, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions()) else { return }
    while let file = fileEnumerator.nextObject() {
        let fileNameURL = file as! NSURL
        let fileNameStr = fileNameURL.lastPathComponent
        let fileType = fileNameStr?.extension
        //newFileCLass.name = fileNameStr ?? "Fail"
        //newFileCLass.type = fileType ?? "Fail"
        //print(file)
        //print(newFileCLass.name)
        //print(newFileCLass.type)
        fileListArray.append(newArray)
        fileListArray[i].name = fileNameStr ?? "Fail"
        fileListArray[i].type = fileType ?? "Fail"
        print(fileListArray[i].name)
        print(i)
        i += 1
    }
}
