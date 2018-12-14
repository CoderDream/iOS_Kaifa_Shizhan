//
//  ViewController.swift
//  ProductInfoPlist
//
//  Created by CoderDream on 2018/12/14.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 创建4个文本框的输出接口集合（数组）
    @IBOutlet var textFields: [UITextField]!
    
    @IBAction func saveInfoBtnAction(_ sender: UIButton) {
        print("saveInfoBtnAction")
        // 获取数据存储文件的路径
        let fileURL = self.dataFileURL()
        // 用 textFields 数组中每个文本框的text属性构建一个字符串数组，并调用value(forKey:)方法传递文本作为参数
        let array = (self.textFields as NSArray).value(forKey: "text") as! NSArray
        // 将数据写入到数据存储文件
        array.write(to: fileURL as URL, atomically: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 获取数据存储文件的路径
        let fileURL = self.dataFileURL()
        // 检查数据存储文件是否存在：不存在就不加载，存在就用该文件的内容实例化数组，并将数组中的对象加载到4个文本框中
        if FileManager.default.fileExists(atPath: fileURL.path!) {
            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
                for i in 0..<array.count {
                    textFields[i].text = array[i]
                }
            }
        }
    }

    @objc func applicationWillResignActive(notification: NSNotification) {
        print("applicationWillResignActive")
        // 获取数据存储文件的路径
        let fileURL = self.dataFileURL()
        // 用 textFields 数组中每个文本框的text属性构建一个字符串数组，并调用value(forKey:)方法传递文本作为参数
        let array = (self.textFields as NSArray).value(forKey: "text") as! NSArray
        // 将数据写入到数据存储文件
        array.write(to: fileURL as URL, atomically: true)
    }

    // 获取数据存储文件路径的方法
    func dataFileURL() -> NSURL {
       // 获取应用程序的Documents目录，并在其后附加数据存储文件名
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentURL = urls.first!
        return documentURL.appendingPathComponent("textData.plist") as NSURL
    }
    
}

