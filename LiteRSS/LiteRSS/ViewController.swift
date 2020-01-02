//
//  ViewController.swift
//  LiteRSS
//
//  Created by CoderDream on 2020/1/2.
//  Copyright © 2020 CoderDream. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import AlamofireXmlToObjects
import EVReflection

class WeatherResponse: EVObject {
    var location: String?
    var three_day_forecast: [Forecast] = [Forecast]()
}

class Forecast: EVObject {
    var day: String?
    var temperature: NSNumber?
    var conditions: String?
}

class CnbetaResponse: EVObject {
    var rss: Rss?
}

class Rss: EVObject {
    var __name: String?
    var _version: String?
    var channel: Channel?
}

class Channel: EVObject {
    var title: String?
    var link: String?
    var language: String?
    var copyright: String?
    var image: EVImage? = nil
    var item: [Item] = [Item]()
    
    var descriptions: String?
    var generator: String?
    var pubDate: String?
    
    // 关键字别名，例如 description 是系统的关键字，那我们用别名 descriptions 代替
    override internal func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [("descriptions", "description")]
    }
}

class EVImage: EVObject {
    var url: String?
    var title: String?
    var link: String?
}

class Item: EVObject {
    var title: String?
    var link: String?
    var descriptions: String?
    var author: String?
    var source: String?
    var pubDate: String?
    var guid: String?
    
    // 关键字别名，例如 description 是系统的关键字，那我们用别名 descriptions 代替
    override internal func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [("descriptions", "description")]
    }
}

class ViewController: UIViewController, XMLParserDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.getRequest()
//        let xmlUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "data", ofType: "xml")!)
//        let parser = XMLParser(contentsOf: xmlUrl)
//        parser?.delegate = self
//        parser?.parse()
//        test1()
        test2()
    }
    
    func getRequest() {
        //
//        let url = "https://httpbin.org/get"
        let url = "https://www.cnbeta.com/backend.php"
        //
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response { (response) in
            if response.error == nil {
                print("success")
                //
                //let json = response.result.value
                print("JSON: \(String(describing: response))")
//                let parser = XMLParser(response)
//                parser?.delegate = self
//                parser?.parse()
                //var xml = SWXMLHash.parse(response.result.value!)
                //print(xml)
                
            } else {
                print("failure: \(String(describing: response.error))")
            }
        }
    }

    //记录当前节点的名字
    var currentNodeName:String!

    //获取节点及属性
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        //记录当前节点
        currentNodeName = elementName
        
        //打印person节点的id属性及值
        if elementName == "person"{
            if let id = attributeDict["id"]{
                print("id:\(id)")
            }
        }
        
    }
    
    //获取节点的文本内容
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //获取
        let str = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        //输出当前节点和文本
        if str != ""{
            print("当前节点:\(currentNodeName!)的文本:\(str)")
        }
    }
    
    func test1() {
    
        let URL = "https://raw.githubusercontent.com/evermeer/AlamofireXmlToObjects/master/AlamofireXmlToObjectsTests/sample_xml"
        Alamofire.request(URL).responseObject { (response: DataResponse<WeatherResponse>) in
            if let result = response.value {
            // That was all... You now have a WeatherResponse object with data
                print(result)
            }
        }
    }
    
    func test2() {
        
        let URL = "https://www.cnbeta.com/backend.php"
        Alamofire.request(URL).responseObject { (response: DataResponse<Rss>) in
            if let result = response.value {
                // That was all... You now have a WeatherResponse object with data
                print(result)
            }
        }
    }
}
