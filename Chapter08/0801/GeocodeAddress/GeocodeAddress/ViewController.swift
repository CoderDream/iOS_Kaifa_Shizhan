//
//  ViewController.swift
//  GeocodeAddress
//
//  Created by coderdream on 2018/12/13.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.keywordTextField.text = "武汉理工大学"
    }

    @IBAction func geocodeAddressBtnAction(_ sender: UIButton) {
        if keywordTextField.text == nil {
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(keywordTextField.text!) { (placemarks, error) in
            if error != nil {
                print(self.keywordTextField.text!)
                print("ERROR: \(String(describing: error?.localizedDescription))")
            } else if placemarks!.count > 0 {
                print(self.keywordTextField.text!)
                // 取出第一个地址
                let placemark = placemarks![0] as CLPlacemark
                let name = placemark.name!
                let location = placemark.location!
                let lng = location.coordinate.longitude
                let lat = location.coordinate.latitude
                let info = String(format: "经度：%3.5f\n纬度：%3.5f\n%@", lng, lat, name)
                print(info)
                self.addressLabel.text = info
            }
        }
        // 收回键盘
        self.keywordTextField.resignFirstResponder()
        
    }
    
}

