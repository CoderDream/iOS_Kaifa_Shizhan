//
//  ViewController.swift
//  ProductInfoCoreData
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // 定义实体Line、行号LineNumber和文本LineText的字符串
    private static let lineEntityName = "Line"
    private static let lineNumberKey = "lineNumber"
    private static let lineTextKey = "lineText"
    
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 获取应用程序代理
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 获取托管对象上下文（它相当于一个临时保存对象的容器，添加、修改和删除对象等操作都由它完成，操作完成后，再将最后数据保存到数据库中）
        let context = appDelegate.managedObjectContext
        // 创建一个提取请求，并传递实体名称“Line”给它
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ViewController.lineEntityName)
        
        do {
            // 通过托管对象上下文context执行提取请求request，获取记录对象的数组，并确认数组有效
            let objects = try context.fetch(request)
            // 遍历数组，分别提取每个托管对象保存的数据，并将其加载到文本框中
            for object in objects {
                // 获取行号（转换为Int）
                let lineNumber: Int = (object as AnyObject).value(forKey: ViewController.lineNumberKey)! as! Int
                // 获取文本
                let lineText = (object as AnyObject).value(forKey: ViewController.lineTextKey)! as! String
                // 赋值给对应行号的文本框字段
                let textField = textFields[lineNumber]
                textField.text = lineText
            }
            
            // 当应用程序即将终止运行时，获取通知并保存文本框中的数据
            let app = UIApplication.shared
            NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: app)
        } catch {
            // 如果fetch()方法抛出异常，则打印错误提示
            print("获取记录对象时出错：\(error)")
        }
    }

    @IBAction func saveInfoBtnAction(_ sender: UIButton) {
        // 获取应用程序代理
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 获取托管对象上下文（它相当于一个临时保存对象的容器，添加、修改和删除对象等操作都由它完成，操作完成后，再将最后数据保存到数据库中）
        let context = appDelegate.managedObjectContext
        for i in 0 ..< textFields.count {
            let textField = textFields[i]
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ViewController.lineEntityName)
            let pred = NSPredicate(format: "%K = %d", ViewController.lineNumberKey, i)
            request.predicate = pred
            do {
                let objects = try context.fetch(request)
                var theLine: NSManagedObject! = objects.first as? NSManagedObject
                if theLine == nil {
                    // 如果不存在有效对象，则创建新的托管对象
                    theLine = NSEntityDescription.insertNewObject(forEntityName: ViewController.lineEntityName, into: context) as NSManagedObject
                }
                // 返回有效对象时，加载数据，更新设置行号和文本
                theLine.setValue(i, forKey: ViewController.lineNumberKey)
                theLine.setValue(textField.text, forKey: ViewController.lineTextKey)
            } catch {
                print("获取记录对象时出错：\(error)")
            }
            // 通知上下文保存数据更改
            appDelegate.saveContext()
        }
    }
    
    //当应用程序即将进入非活动状态（如转入后台）时，保存用户对数据的更改
    @objc func applicationWillResignActive(_ notification: Notification) {
        // 获取应用程序代理
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 获取托管对象上下文（它相当于一个临时保存对象的容器，添加、修改和删除对象等操作都由它完成，操作完成后，再将最后数据保存到数据库中）
        let context = appDelegate.managedObjectContext
        for i in 0 ..< textFields.count {
            let textField = textFields[i]
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ViewController.lineEntityName)
            let pred = NSPredicate(format: "%K = %d", ViewController.lineNumberKey, i)
            request.predicate = pred
            do {
                let objects = try context.fetch(request)
                var theLine: NSManagedObject! = objects.first as? NSManagedObject
                if theLine == nil {
                    // 如果不存在有效对象，则创建新的托管对象
                    theLine = NSEntityDescription.insertNewObject(forEntityName: ViewController.lineEntityName, into: context) as NSManagedObject
                }
                // 返回有效对象时，加载数据，更新设置行号和文本
                theLine.setValue(i, forKey: ViewController.lineNumberKey)
                theLine.setValue(textField.text, forKey: ViewController.lineTextKey)
            } catch {
                print("获取记录对象时出错：\(error)")
            }
            // 通知上下文保存数据更改
            appDelegate.saveContext()
        }
    }
    
}

