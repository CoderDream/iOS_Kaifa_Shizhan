//
//  ViewController.swift
//  ProductInfoSQLite
//
//  Created by coderdream on 2018/12/14.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 创建4个文本框的输出接口集合（数组）
    @IBOutlet var textFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 获取数据存储文件的路径
//        let fileURL = self.dataFileURL()
//        // 检查数据存储文件是否存在：不存在就不加载，存在就用该文件的内容实例化数组，并将数组中的对象加载到4个文本框中
//        if FileManager.default.fileExists(atPath: fileURL.path!) {
//            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
//                for i in 0..<array.count {
//                    textFields[i].text = array[i]
//                }
//            }
//        }
        
        // 定义一个数据库变量（实质是一个 sqlite3 类型的C语音结构体，视为不透明指针即可）
        var database: OpaquePointer? = nil
        // 打开数据库（如果指定位置上不存在，则创建一个新的数据库）
        // 若resultw等于SQLITE_OK，则表示数据库已成功打开
        var result = sqlite3_open(dataFilePath(), &database)
        
        // 如果打开数据库遇到问题，则关闭数据库并输出错误提示
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("无法打开数据库")
            return
        }
        
        // 通过SQL语句和sqlite3_exec在打开的数据库中创建一个新表FIELDS，用于保存数据
        // IF NOT EXISTS可以防止覆盖现有数据（如果该表已经存在，则不执行任何操作）
        // 表中每一行包含一个整型ROW（行号，从0开始计数）和一个文本字段FIELD_DATA（对应行中文本框的内容）
        // let createSQL = "CREATE TABLE IF NOT EXISTS FIELDS " + "(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT);"
        let createSQL = "CREATE TABLE IF NOT EXISTS FIELDS " + "(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT);"
        var errMsg: UnsafeMutablePointer<Int8>? = nil
        result = sqlite3_exec(database, createSQL, nil, nil, &errMsg)
        
        // 如果创建表 FIELDS 遇到问题，则关闭数据库并输出错误提示
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("无法创建表")
            return
        }
        
        // 如果创建表FIELDS成功（即result等于SQLITE_OK)，则使用SELECT语句遍历结果集，加载数据
        // 从数据库FIELDSj请求所有行，并按行号排序各行
        let query = "SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW"
        // statement 变量实质是一个sqlite3_stmt类型的C语言结构体，故视为不透明指针
        var statement: OpaquePointer? = nil
        // sqlite3_perpare_v2函数可将SQL文本转换成一个准备语句对象statement，如果执行成功则返回SQLITE_OK
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            // 用 sqlite3_step 函数执行SELECT语句，并遍历返回的每一行
            while sqlite3_step(statement) == SQLITE_ROW {
                // 获取行号并存储在一个Int型变量中
                let row = Int(sqlite3_column_int(statement, 0))
                // 获取文本字段并存储在一个C语言字符串中，再将该字符串转换成Swift格式的String型
                let rowData = sqlite3_column_text(statement, 1)
                let fieldValue = String(cString: rowData!)
                // 利用从数据库获取的值设置各个文本框的文本
                textFields[row].text = fieldValue
            }
            sqlite3_finalize(statement)
        }
        // 关闭数据库
        sqlite3_close(database)
        
        //当应用程序即将终止运行时，获取通知并保存文本框中的数据
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: app)
    }


    @IBAction func saveInfoAction(_ sender: UIButton) {
        print("saveInfoBtnAction")
        // 获取数据存储文件的路径
//        let fileURL = self.dataFileURL()
//        // 用 textFields 数组中每个文本框的text属性构建一个字符串数组，并调用value(forKey:)方法传递文本作为参数
//        let array = (self.textFields as NSArray).value(forKey: "text") as! NSArray
//        // 将数据写入到数据存储文件
//        array.write(to: fileURL as URL, atomically: true)
        var database: OpaquePointer? = nil
        // 打开数据库
        let result = sqlite3_open(dataFilePath(), &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("无法打开数据库")
            return
        }
        // 保存数据（在4个字段中进行循环，生成4条独立的命令来更新数据库中FIELDS表的每一行)
        for i in 0..<textFields.count {
            let field = textFields[i]
            // 定义SQL语句以更新数据库的表数据
            let update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA) " + "VALUES (?, ?);"
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK {
                let text = field.text
                // 使用两个绑定变量预处理语句SQL语句
                sqlite3_bind_int(statement, 1, Int32(i))            // 绑定行号
                sqlite3_bind_text(statement, 2, text!, -1, nil)     // 绑定文本字段
            }
            // 调用sqlite3_step函数执行更新，检查并确定其运行正常（如果执行正常，则返回SQLITE_DONE）
            if sqlite3_step(statement) != SQLITE_DONE {
                print("更新表时出错")
                sqlite3_close(database)
                return
            }
            
            sqlite3_finalize(statement)
        }
        // 关闭数据库
        sqlite3_close(database)
    }
    
    //当应用程序即将进入非活动状态（如转入后台）时，保存用户对数据的更改
    @objc func applicationWillResignActive(notification: NSNotification) {
        var database: OpaquePointer? = nil
        // 打开数据库
        let result = sqlite3_open(dataFilePath(), &database)
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("无法打开数据库")
            return
        }
        // 保存数据（在4个字段中进行循环，生成4条独立的命令来更新数据库中FIELDS表的每一行)
        for i in 0..<textFields.count {
            let field = textFields[i]
            // 定义SQL语句以更新数据库的表数据
            let update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA) " + "VALUES (?, ?);"
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK {
                let text = field.text
                // 使用两个绑定变量预处理语句SQL语句
                sqlite3_bind_int(statement, 1, Int32(i))            // 绑定行号
                sqlite3_bind_text(statement, 2, text!, -1, nil)     // 绑定文本字段
            }
            // 调用sqlite3_step函数执行更新，检查并确定其运行正常（如果执行正常，则返回SQLITE_DONE）
            if sqlite3_step(statement) != SQLITE_DONE {
                print("更新表时出错")
                sqlite3_close(database)
                return
            }
            
            sqlite3_finalize(statement)
        }
        // 关闭数据库
        sqlite3_close(database)
    }
    // 获取数据存储文件路径的方法
    func dataFilePath() -> String {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentPath: String?
        // SQLite3需要用路径文件进行操作，不支持URL，所以此处返回的不是文件的URL，而是路径
        documentPath = paths.first!.appendingPathComponent("textData2.plist").path
        return documentPath!
    }
}

