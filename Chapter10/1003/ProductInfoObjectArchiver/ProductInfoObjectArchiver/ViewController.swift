//
//  ViewController.swift
//  ProductInfoObjectArchiver
//
//  Created by CoderDream on 2018/12/14.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 定义一个常量，作为编码和解码的键
    private static let rootKey = "rootKey"

    //创建4个文本框的输出接口集合（数组）
    @IBOutlet var textFields: [UITextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 获取数据存储文件的路径
        let fileURL = self.dataFileURL()
        // 检查数据存储文件是否存在：不存在就不加载，存在就用该文件的内容实例化数组
        if FileManager.default.fileExists(atPath: fileURL.path!) {
            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
                for i in 0..<array.count {
                    textFields[i].text = array[i]
                }
            }
            // 创建一个 NSMutableData 实例，从数据存储文件中读取数据
            let data = NSMutableData(contentsOf: fileURL as URL)
            // 将数据包装在一个反归档对象中，通过反归档对象对数据进行加密
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data! as Data)
            // Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
            let fourLines = unarchiver.decodeObject(forKey: ViewController.rootKey) as! FourLines
            // 告知反归档程序已完成解码
            unarchiver.finishDecoding()
            // 将数据加载到4个文本框中
            if let newLines = fourLines.lines {
                for i in 0..<newLines.count {
                    textFields[i].text = newLines[i]
                }
            }
            print("done")
        }
        
        // 当应用程序即将终止运行时，获取通知并保存文本框中的数据
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    //当应用程序即将进入非活动状态（如转入后台）时，保存用户对数据的更改
    @objc func applicationWillResignActive(notification: NSNotification) {
        let fileURL = self.dataFileURL()
        let fourLines = FourLines()
        let array = (self.textFields as NSArray).value(forKey: "text") as! [String]
        fourLines.lines = array
        //创建一个NSMutableData实例，用于包含编码的数据
        let data = NSMutableData()
        //创建一个NSKeyedArchiver实例，用于将对象归档到NSMutableData实例中
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //对所有要包含在归档中的对象进行编码
        archiver.encode(fourLines, forKey: ViewController.rootKey)
        //告知归档程序已完成编码
        archiver.finishEncoding()
        //将NSMutableData实例写入数据存储文件
        data.write(to: fileURL as URL, atomically: true)
    }
    
    @IBAction func saveInfoBtnAction(_ sender: UIButton) {
        print("saveInfoBtnAction")
        // 获取数据存储文件的路径
        let fileURL = self.dataFileURL()
        let fourLines = FourLines()
        
        // 用 textFields 数组中每个文本框的text属性构建一个字符串数组，并调用value(forKey:)方法传递文本作为参数
        let array = (self.textFields as NSArray).value(forKey: "text") as! [String]
        fourLines.lines = array
        // 创建一个 NSMutableData 实例，用于包含编码的数据
        let data = NSMutableData()
        // 创建一个 NSKeyArchivers 实例，用于将对象归档到 NSMutableData 实例中
       // 'init(forWritingWith:)' was deprecated in iOS 12.0: Use -initRequiringSecureCoding: instead
        let archiver = NSKeyedArchiver(forWritingWith: data)
        // 对所有要包含在归档中的对象进行编码
        archiver.encode(fourLines, forKey: ViewController.rootKey)
        // 告知归档程序已完成编码
        archiver.finishEncoding()
        // 将数据写入到数据存储文件
        data.write(to: fileURL as URL, atomically: true)
    }



    // 获取数据存储文件路径的方法
    func dataFileURL() -> NSURL {
        // 获取应用程序的Documents目录，并在其后附加数据存储文件名
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentURL = urls.first!
        return documentURL.appendingPathComponent("textData.plist") as NSURL
    }
}

