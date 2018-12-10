//
//  ViewController.swift
//  BlockOperation
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 1.同步执行一个操作
        let myOperation = BlockOperation {
            print("执行了一个新的操作")
        }
        // 开始执行任务
        myOperation.start()
        
        
        // 2.并发执行多个操作
        let operation = BlockOperation {
            print("执行第一次操作，线程：\(Thread.current)")
        }
        
        // 添加新的操作
        operation.addExecutionBlock {
            print("又执行一次操作，线程：\(Thread.current)")
        }
        // 添加新的操作
        operation.addExecutionBlock {
            print("又执行一次操作，线程：\(Thread.current)")
        }
        // 添加新的操作
        operation.addExecutionBlock {
            print("又执行一次操作，线程：\(Thread.current)")
        }
        // 开始执行任务
        operation.start()        
    }


}

