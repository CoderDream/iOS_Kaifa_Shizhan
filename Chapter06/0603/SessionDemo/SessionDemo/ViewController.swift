//
//  ViewController.swift
//  SessionDemo
//
//  Created by CoderDream on 2018/12/11.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //加载数据
        //self.sessionDataTask()
    
        //下载文件
        self.sessionDownloadTask()
    }
    
    
    func sessionDataTask() {
        //1.创建URL对象
        let url: URL! = URL(string: "http://api.3g.ifeng.com/clientShortNews?type=beauty")
        //2.创建请求对象
        let urlRequest: URLRequest = URLRequest(url: url)
        //3.创建会话
        let session = URLSession.shared
        //4.创建加载任务
        let myDataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if(error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                
                do {
                    //解析JSON数据
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    print(dic)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            } as URLSessionDataTask
        //5.启动任务
        myDataTask.resume()
    }



func sessionDownloadTask() {
    //1.创建URL下载地址
    let url: URL! = URL(string: "http://d.ifengimg.com/w166/p2.ifengimg.com/web/2018_06/14dd5579525f97d_w960_h1440.jpg")
    //2.创建请求对象
    let urlRequest: URLRequest = URLRequest(url: url)
    //3.创建会话
    let session = URLSession.shared
    //4.创建下载任务
    let myDownloadTask = session.downloadTask(with: urlRequest) { (location: URL?, response: URLResponse?, error: Error?) in
        //location位置转换
        let locationPath = location?.path
        //复制到我们自己的目录（需相应修改）中
        let documentPath: String = "/Users/Anonymous/Desktop/下载的图片.png/"
        //创建文件管理器
        let fileManager: FileManager = FileManager.default
        do {
            try fileManager.moveItem(atPath: locationPath!, toPath: documentPath)
        } catch let error {
            print(error.localizedDescription)
        }
        } as URLSessionDownloadTask
    //5.启动任务
    myDownloadTask.resume()
}
}

