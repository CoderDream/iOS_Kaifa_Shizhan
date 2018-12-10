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
        
        
    }


}

