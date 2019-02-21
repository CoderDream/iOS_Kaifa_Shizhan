//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by CoderDream on 2019/2/21.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getRequest()        
    }

    func getRequest() {
        //
        let url = "https://httpbin.org/get"
        //
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.error == nil {
                print("success")
                //
                let json = response.result.value
                print("JSON: \(String(describing: json))")
            } else {
                print("failure: \(String(describing: response.error))")
            }
        }
    }

}

