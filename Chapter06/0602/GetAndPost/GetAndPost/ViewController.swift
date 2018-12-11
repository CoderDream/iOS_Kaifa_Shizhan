//
//  ViewController.swift
//  GetAndPost
//
//  Created by CoderDream on 2018/12/11.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.getRequest()
        
        self.postRequest()
    }

    func getRequest() {
        // 对请求路径的说明
        // http://120.25.226.186:32812/login?username=lucy&pwd=123456&type=JSON
        // 协议头+主机地址+接口名称+?+参数1&参数2&参数3
        // 协议头(http://)+主机地址(120.25.226.186:32812)+接口名称(login)+?+参数1(username=lucy)&参数2(pwd=123456)&参数3(type=JSON)
        // GET请求直接将参数放在URL后面，以?隔开；多个参数之间以&符号拼接
        
        //1.确定请求路径
//        let username = "lucy"
//        let pwd = "123456"
//        let urls = String(format: "http://120.25.226.186:32812/login?username=%@&pwd=%@&type=%@", username, pwd, "JSON")
        // http://www.kuaidi100.com/query?type=yuantong&postid=11111111111
       // let urls = "http://www.kuaidi100.com/query?type=yuantong&postid=11111111111"
        
        
        
        // lat 31.2990170   纬度
        //log 121.3466440    经度
        //String add = getAdd("121.3466440", "31.2990170");
        //JSONObject jsonObject = JSONObject.fromObject(add);
        //JSONArray jsonArray = JSONArray.fromObject(jsonObject.getString("addrList"));
        //JSONObject j_2 = JSONObject.fromObject(jsonArray.get(0));
        //String allAdd = j_2.getString("admName");
        //String arr[] = allAdd.split(",");
        //System.out.println("省:"+arr[0]+"\n市:"+arr[1]+"\n区:"+arr[2]);
    
    //参数解释: 纬度,经度 type 001 (100代表道路,010代表POI,001代表门址,111可以同时显示前三项)
   // String urlString = "http://gc.ditu.aliyun.com/regeocoding?l="+lat+","+log+"&type=010";
        // http://www.kuaidi100.com/query?type=yunda&postid=3876430019724
        let type = "yunda"
        let postid = "3876430019724"
        let urls = String(format: "http://www.kuaidi100.com/query?type=%@&postid=%@", type, postid, "JSON")
        print(urls)
        let url: URL = URL(string: urls)!
        
        //2.创建请求对象（可省略）
        //请求对象内部默认已经包含了请求头和请求方法（GET）
        //let request: URLRequest = URLRequest(url: url)
        
        //3.创建简单会话对象
        let session: URLSession = URLSession.shared
        
        //4.根据会话对象创建一个Task（发送请求）
        let dataTask = session.dataTask(with: url) { (data, respond, error) in
            
            if let data = data {
                //6.解析服务器返回的数据（数据是JSON格式，故使用JSONSerialization进行反序列化处理）
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    
                    print(result)
                }
            } else {
                
            }
        }
        //5.执行任务
        dataTask.resume()
    }
    
    func postRequest() {
        print("postRequest()")
        //对请求路径的说明
        //http://120.25.226.186:32812/login
        //协议头+主机地址+接口名称
        //协议头(http://)+主机地址(120.25.226.186:32812)+接口名称(login)
        //需修改请求方法为POST，把参数转换为二进制数据并设置请求体
        
//        //1.确定请求路径
//        let url = URL(string: "http://120.25.226.186:32812/login")
//        //2.创建可变的请求对象
//        var request = URLRequest.init(url: url!)
//        //3.修改请求方法为POST
//        request.httpMethod = "POST"
//        //4.设置请求体
//        let username = "lucy"
//        let pwd = "123456"
//        let urls = String(format: "http://120.25.226.186:32812/login?username=%@&pwd=%@&type=%@", username, pwd, "JSON")

        let lat = "34.350178"
        let log = "108.949324"
        let url = URL(string: "http://gc.ditu.aliyun.com/regeocoding")
        //2.创建可变的请求对象
        var request = URLRequest.init(url: url!)
        //3.修改请求方法为POST
        request.httpMethod = "POST"
        let urls = String(format: "http://gc.ditu.aliyun.com/regeocoding?l=%@,%@&type=010", lat, log,"JSON")
        //4.设置请求体
//        let username = "lucy"
//        let pwd = "123456"
//        let urls = String(format: "http://120.25.226.186:32812/login?username=%@&pwd=%@&type=%@", username, pwd, "JSON")
        
        
        request.httpBody = urls.data(using: .utf8)
        //5.创建会话对象
        let session = URLSession.shared
        //6.根据会话对象创建一个Task（发送请求）
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let data = data {
                //8.解析数据（数据是JSON格式，故使用JSONSerialization进行反序列化处理）
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any> {
                    //用数组来接数据
                    let dataArray = result?["result"] as? [[String: Any]]
                    if dataArray != nil{
                        //遍历数组
                        for dic in dataArray! {
                            //获取member数组
                            let array = dic["member"] as? [[String: Any]]
                            print(array as Any)
                        }
                    }
                }
                
            } else {
            }
        }
        //7.执行任务
        dataTask.resume()
    }

}

