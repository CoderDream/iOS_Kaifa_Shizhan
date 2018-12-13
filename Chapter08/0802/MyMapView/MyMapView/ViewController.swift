//
//  ViewController.swift
//  MyMapView
//
//  Created by coderdream on 2018/12/13.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    // 地图视图控件
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 默认显示标准地图
        self.mapView.mapType = .standard
        // 设置显示地图的中心点
        let location = CLLocation(latitude: 30.34730, longitude: 114.34730)
        // 设置地图显示的区域和缩放比例
        // MKCoordinateRegion.init(center:latitudinalMeters:longitudinalMeters:)
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.region = region
    }

    // 分段控件的点击事件
    @IBAction func changeMapViewAction(_ sender: UISegmentedControl) {
        let segment = sender
        switch segment.selectedSegmentIndex {
        case 1:
            // 卫星地图
            self.mapView.mapType = .satellite
        case 2:
            // 混合地图
            self.mapView.mapType = .hybrid
        default:
            // 标准地图
            self.mapView.mapType = .standard
        }
    }

}

