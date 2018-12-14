//
//  Annotation.swift
//  AddMarkPoint
//
//  Created by coderdream on 2018/12/13.
//  Copyright © 2018 coderdream. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    // 地址的名字属性
    var subName: String!
    // 地理坐标
    var coordinate: CLLocationCoordinate2D
    // 初始化方法
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    // 主标题属性
    var title: String? {
        return "您搜索的位置："
    }
    
    // 副标题属性
    var subtitle: String? {
        return self.subName
    }
}

