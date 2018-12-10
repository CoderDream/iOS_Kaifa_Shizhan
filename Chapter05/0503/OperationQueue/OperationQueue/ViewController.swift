//
//  ViewController.swift
//  OperationQueue
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 创建队列
        let myQueue = OperationQueue.main
        myQueue.addOperation {
            print(Thread.current)
        }
        // 创建串行队列
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1           // 最大并发数
        queue.addOperation {
            for _ in 0...10000 {
                print("OperationQueue1执行了 \(Thread.current)")
            }
        }
        
        queue.cancelAllOperations()
        queue.isSuspended = true
        queue.isSuspended = false
        queue.waitUntilAllOperationsAreFinished()
    }


}

