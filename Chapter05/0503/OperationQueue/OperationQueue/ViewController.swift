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
//        let queue = OperationQueue()
//        queue.maxConcurrentOperationCount = 1           // 最大并发数
//        queue.addOperation {
//            for _ in 0...10000 {
//                print("OperationQueue1执行了 \(Thread.current)")
//            }
//        }
//
//        queue.cancelAllOperations()                 // 取消队列所有操作
//        queue.isSuspended = true                    // 暂停队列
//        queue.isSuspended = false                   // 恢复队列
//        queue.waitUntilAllOperationsAreFinished()   // 等待队列操作完成
        
        
        /*添加Operation的依赖对象 */
         let queue = OperationQueue()
         
         let blockOpe1 = BlockOperation()
         blockOpe1.addExecutionBlock {
            print("blockOpe1执行了")
         }
         
         let blockOpe2 = BlockOperation()
         blockOpe2.addExecutionBlock {
            print("blockOpe2执行了")
         }
         
         //设置依赖关系
         blockOpe1.addDependency(blockOpe2)
         queue.addOperation(blockOpe1)
         queue.addOperation(blockOpe2)
         
         //删除依赖关系
         blockOpe1.removeDependency(blockOpe2)

        
        
        /*修改Operations的执行顺序
         let queue = OperationQueue()
         let blockOpe = BlockOperation()
         blockOpe.queuePriority = .low            //等级：veryLow，low，normal，high，veryHigh
         queue.addOperation(blockOpe)
 */
        
    }


}

