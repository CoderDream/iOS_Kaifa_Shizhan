//
//  ViewController.swift
//  GCGTest
//
//  Created by coderdream on 2018/12/10.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 创建一个串行队列
        // let serialQueue = DispatchQueue(
        let serialQueue = DispatchQueue(label: "serial", attributes: .init(rawValue: 0))
        //创建一个并发队列
        let conQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
        //获得全局并发队列
        let globalQueue = DispatchQueue.global()
        //获得主队列
        let mainQueue = DispatchQueue.main
        
        serialQueue.async {
            print(Thread.current)
        }
        conQueue.async {
            print(Thread.current)
        }
        globalQueue.async {
            print(Thread.current)
        }
        mainQueue.async {
            print(Thread.current)
        }
        
        /* 4种队列组合
         //1）同步+串行队列
         func sync_serial() {
             //创建一个串行队列
             let serialQueue = DispatchQueue(label: "serial", attributes: .init(rawValue: 0))
             //同步执行三个任务
             serialQueue.sync {
                print("1 + \(Thread.current)")
             }
             serialQueue.sync {
                print("2 + \(Thread.current)")
             }
             serialQueue.sync {
                print("3 + \(Thread.current)")
             }
         }
         sync_serial()
 
        
         //2）异步+串行队列
         func async_serial() {
             //创建一个串行队列
             let serialQueue = DispatchQueue(label: "serial", attributes: .init(rawValue: 0))
             //异步执行三个任务
             serialQueue.async {
                print("1 + \(Thread.current)")
             }
             serialQueue.async {
                print("2 + \(Thread.current)")
             }
             serialQueue.async {
                print("3 + \(Thread.current)")
             }
         }
         async_serial()
        
         //3）同步+并发队列
        func sync_concurrent() {
            //创建一个全局队列
            let globalQueue = DispatchQueue.global()
            //同步执行三个任务
            globalQueue.sync {
                print("1 + \(Thread.current)")
            }
            globalQueue.sync {
                print("2 + \(Thread.current)")
            }
            globalQueue.sync {
                print("3 + \(Thread.current)")
            }
        }
        sync_concurrent()*/
        
         //4）异步+并发队列
        func async_concurrent() {
            //创建一个全局队列
            let globalQueue = DispatchQueue.global()
            //异步执行三个任务
            globalQueue.async {
                print("1 + \(Thread.current)")
            }
            globalQueue.async {
                print("2 + \(Thread.current)")
            }
            globalQueue.async {
                print("3 + \(Thread.current)")
            }
        }
        async_concurrent()
          /* */
        
    }


}

