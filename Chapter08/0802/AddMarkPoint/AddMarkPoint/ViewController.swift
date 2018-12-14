//
//  ViewController.swift
//  AddMarkPoint
//
//  Created by coderdream on 2018/12/13.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mapView.mapType = .standard
        self.mapView.delegate = self
    }

    @IBAction func gencodeAddressAction(_ sender: UIButton) {
        if keywordTextField.text == nil {
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(keywordTextField.text!) { (placemarks, error) in
            // 清除所有标记点
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            if placemarks != nil {
                // 取出查询到的每个地址并没有设置标注点
                for placemark in placemarks! {
                    let annotation = Annotation(coordinate: placemark.location!.coordinate)
                    annotation.subName = placemark.name
                    // 添加标注点
                    self.mapView.addAnnotation(annotation)
                }
                // 取出最后一个位置信息显示在地图上
                let lastPlace = placemarks!.last
                let region = MKCoordinateRegion.init(center: lastPlace!.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.mapView.setRegion(region, animated: true)
            }
        }
        // 收回键盘
        self.keywordTextField.resignFirstResponder()
    }
    
    // 给地图视图添加标注时回调
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 从地图中取出一个带有标记的大头针（获得地图标注对象）
        var annotation = self.mapView.dequeueReusableAnnotationView(withIdentifier: "CusAnn") as? MKPinAnnotationView
        if annotation == nil {
            // 初始化一个大头针
            annotation = MKPinAnnotationView(annotation: annotation as? MKAnnotation, reuseIdentifier: "CusAnn")
        }
        // 大头针颜色
        annotation!.pinTintColor = UIColor.red
        // 大头针掉落在地图上的动画
        annotation!.animatesDrop = true
        // 点击大头针是否显示主标题和副主标题信息
        annotation?.canShowCallout = true
        return annotation
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("error:\(error.localizedDescription)")
    }
}

