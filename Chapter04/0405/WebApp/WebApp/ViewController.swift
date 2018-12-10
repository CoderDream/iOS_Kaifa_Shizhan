//
//  ViewController.swift
//  WebApp
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    
    
    @IBAction func loadHtmlBtnAction(_ sender: UIButton) {
        // 定义 url
        let url = NSURL(string: "https://www.baidu.com")
        // 定义请求
        let request = NSURLRequest(url: url! as URL)
        // 加载请求
        self.myWebView.loadRequest(request as URLRequest)
        // 设置代理
        self.myWebView.delegate = self
    }
    
    @IBAction func loadStringBtnAction(_ sender: UIButton) {
        // 获取 baseURL
        let bundleURL = URL.init(fileURLWithPath: Bundle.main.bundlePath)
        // 自定义 HTML 字符串
        let htmlStr = "<html><head><meta charset=\"UTF-8\"><title>主标题|副标题</title></head><body><p>Hello World!</p></body></html>"
        // 加载 HTML 字符串
        self.myWebView.loadHTMLString(htmlStr as String, baseURL: bundleURL)
    }
    
    //
    @IBAction func loadPicBtnAction(_ sender: UIButton) {
        // 获取 baseURL
        let bundleURL = URL.init(fileURLWithPath: Bundle.main.bundlePath)
        // 获取本地图片路径
        let imagePath = Bundle.main.path(forResource: "rocket", ofType: "gif")
        // 获取图片的URL
        let imageUrl = URL.init(fileURLWithPath: imagePath!)
        // 将图片转成 Data
        let imageData = NSData(contentsOf: imageUrl)
        // 加载图片 Data
        self.myWebView.load(imageData! as Data, mimeType: "image/gif", textEncodingName: "", baseURL: bundleURL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

extension ViewController: UIWebViewDelegate {
    
    // 将要加载界面时调用
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        // true 表示允许加载请求，no 表示不允许请求
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("已经开始加载")
    }
    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        print("加载完成“)
//    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("加载失败 error： %@", error.localizedDescription)
    }
}


