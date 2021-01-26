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

func deleteFile(folderPath: String, fileName: String)->Bool{
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

var fileListArray: [String] = [""]
/*
func getFileList(filePath: String) -> [String] {
       // 1.获取文件路径
    let path = Bundle.main.path(forResource: "TestList.json", ofType: nil)
    // 2.通过文件路径创建NSData
    if let jsonPath = path {
        let jsonData = NSData(contentsOfFile: jsonPath)
            
        // 带throws的方法需要抛异常
        do {
            // 3.序列化 data -> array
            let dictArr = try JSONSerialization.jsonObject(with: jsonData! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
            // 4.遍历数组
            // 在Swift中遍历数组，必须明确数据的类型 [[String: String]]表示字典里键值都是字符串 [[String]]表示数组里都是字符串
            for dict in dictArr as! [[String: String]] {
               //return dict
                print(dict)
            }
        }
        catch {
                    // 异常代码放在这
            print(error)
        }
    }
}*/
