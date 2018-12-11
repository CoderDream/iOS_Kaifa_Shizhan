//
//  ViewController.swift
//  GCDOther
//
//  Created by CoderDream on 2018/12/11.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 1. 从子线程回到主线程
        DispatchQueue.global().async {
            // 执行耗时的异步操作...
            DispatchQueue.main.async {
                // 回到主线程，执行UI刷新操作
                print("Done")
            }
        }
        /*
        // 延迟执行
        print("开始执行 \(NSDate())")
        let addtionalTime: DispatchTimeInterval = .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: .now() + addtionalTime, execute: {
            print("3秒后执行 \(NSDate())")
        })
        
        // 2 其他延迟执行方法
        // 方法1
        perform(#selector(run), with: nil, afterDelay: 3.0)
        
        // 方法2
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in
            print("延迟3秒后执行 \(NSDate())")
        })
        */
        
        //创建线程群组
        func group() {
            //获得全局队列
            let globalQueue = DispatchQueue.global()
            //创建一个队列组
            let group = DispatchGroup()
            globalQueue.async(group: group, execute: {
                print("任务一 \(Thread.current)")
            })
            globalQueue.async(group: group, execute: {
                print("任务二 \(Thread.current)")
            })
            //group内的任务完成后，执行此方法
            group.notify(queue: globalQueue, execute: {
                print("终极任务 \(Thread.current)")
            })
            globalQueue.async(group: group, execute: {
                print("任务三 \(Thread.current)")
            })
            globalQueue.async(group: group, execute: {
                print("任务四 \(Thread.current)")
            })
        }
        group()
    }
    
    @objc func run() {
        print("method run()")
    }


}

