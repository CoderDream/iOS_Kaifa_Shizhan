//
//  ViewController.swift
//  LocationTest
//
//  Created by CoderDream on 2018/12/12.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var lngLabel: UILabel!           // 经度
    @IBOutlet weak var latLabel: UILabel!           // 纬度
    @IBOutlet weak var altLabel: UILabel!           // 高度

    @IBOutlet weak var addressLabel: UILabel!       // 地理位置描述信息
    var myLocation:CLLocation!
    
    var locationManager: CLLocationManager!         // 定位服务管理对象
    
    @IBAction func getGeoInfoBtnAction(_ sender: UIButton) {
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 定位服务管理对象初始化
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest // 最高精度
        
        // 表示在地图上每隔200米才更新一次定位信息
        self.locationManager.distanceFilter = 200
        
        // 调用以下两个方法，程序会弹出用户授权对话框
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
                
        self.locationManager.startUpdatingLocation()
    }

    override func viewDidAppear(_ animated: Bool) {
        // 开启定位
        self.locationManager.stopUpdatingLocation()
        print("开启定位")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 停止定位
        self.locationManager.stopUpdatingLocation()
        print("停止定位")
    }
    
    // 定位成功，获得设备当前的经度、纬度和高度信息
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[locations.count - 1] as CLLocation
        let lng: String = NSString(format: "%3.5f", currentLocation.coordinate.longitude) as String
        let lat: String = NSString(format: "%3.5f", currentLocation.coordinate.latitude) as String
        let alt: String = NSString(format: "%3.5f", currentLocation.altitude) as String
        self.lngLabel.text = lng
        self.latLabel.text = lat
        self.altLabel.text = alt
        print("定位成功，获得设备当前的经度\(lng)、纬度\(lat)和高度\(alt)信息")
        self.myLocation = currentLocation
    }
    
    // 定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:\(error.localizedDescription)")
    }
    
    // 授权更改
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("已经授权")
        case .authorizedWhenInUse:
            print("使用时授权")
        case .denied:
            print("拒绝")
        case .restricted:
            print("受限")
        default:
            print("用户还没有授权")
        }
    }

}

