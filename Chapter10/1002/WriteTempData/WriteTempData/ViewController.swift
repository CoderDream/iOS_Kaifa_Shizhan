//
//  ViewController.swift
//  WriteTempData
//
//  Created by CoderDream on 2018/12/14.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 定义一个数组，其包含了需要持久存储的数据
        let array: NSArray = ["葛优", "范伟", "岳云鹏"]
        // 获取当前应用程序的 temp 目录路径
        let tempPath = NSTemporaryDirectory()
        // 将路径字符串转换成 NSURL 对象（即 URL 格式）
        let tempURL = NSURL(fileURLWithPath: tempPath)
        // 将属性列表文件名拼接到 temp 路径后，形成存储文件的完整 URL
        let filePath = tempURL.appendingPathComponent("tempData.plist")
        // 将数组中的数据写入属性文件（如果不存在，会创建该文件）
        array.write(to: filePath!, atomically: true)
        print("Done")
    }
}

