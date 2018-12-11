//
//  ViewController.swift
//  SaleTickets
//
//  Created by CoderDream on 2018/12/11.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showContentTextView: UITextView!
  
    // 定义线程锁，防止多个线程同时使用同一块资源
    let lock = NSLock()
    
    @IBAction func saleTicketsAction(_ sender: UIButton) {
        // 设置总票数
        Ticket.shareTicket.number = 20
        // 清空文本视图内容
        showContentTextView.text = ""
        // 创建一个全局队列
        let globalQueue = DispatchQueue.global()
        // 创建一个队列组
        let group = DispatchGroup()
        // 创建两个任务，模拟两个售票员
        globalQueue.async(group: group, execute: {self.scale(name: "售票员A")})
        globalQueue.async(group: group, execute: {self.scale(name: "售票员B")})
        // 任务完成执行该方法
        group.notify(queue: globalQueue, execute: { print("车票已经售完！")})
    }
    
    // 售票
    func scale(name: String) {
        while true {
            // 开启线程锁
            self.lock.lock()
            if Ticket.shareTicket.number! > 0 {
                // 票数减一
                var num: Int = Ticket.shareTicket.number!
                num -= 1
                Ticket.shareTicket.number = num
                let text = String(format: "剩余票数：[%d] ... %@", Ticket.shareTicket.number!, name)
                // 回到主线程，更新UI，显示票数
                DispatchQueue.main.async {
                    self.appendText(text: text)
                }
                // 关闭线程锁
                self.lock.unlock()
            } else {
                // 关闭线程锁
                self.lock.unlock()
                // 没票可卖
                break
            }
            // 模拟售票员休息时间
            if name == "售票员A" {
                Thread.sleep(forTimeInterval: 2.0)
            } else  {
                Thread.sleep(forTimeInterval: 3.0)
            }
        }
    }
    
    // 给多行文本视图追加文字
    func appendText(text: String) {
        // 取出现有的文本
        var textViewText: String = self.showContentTextView.text
        // 追加文本
        textViewText.append("\n")
        textViewText.append(text)
        // 替换现有文本
        self.showContentTextView.text = textViewText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

