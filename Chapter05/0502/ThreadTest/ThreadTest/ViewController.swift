//
//  ViewController.swift
//  ThreadTest
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 创建
        let myThread = Thread(target: self, selector: #selector(run), object: nil)
        // 启动
        myThread.start()
        // 为开辟的子线程起名字
        myThread.name = "我是第2条线程"
        // 设置线程的优先级
        myThread.threadPriority = 1
        // 获取主线程
        print("当前主线程：\(Thread.main)")
        // 线程休眠（主要用于测试）
        Thread.sleep(forTimeInterval: 1.0)
        // 取消当前已经启动的线程
        myThread.cancel()
        
        // 开启后台执行任务的方法
        self.performSelector(inBackground: #selector(background), with: nil)
        // 返回主线程上执行任务
        self.performSelector(onMainThread: #selector(updateUI), with: nil, waitUntilDone: true)
    }
    
    @objc func run() {
        // 获取当前线程
        print("当前线程：\(Thread.current)")
    }
    
    @objc func background() {
        print("background")
    }
    
    @objc func updateUI() {
        print("updateUI")
    }


}

