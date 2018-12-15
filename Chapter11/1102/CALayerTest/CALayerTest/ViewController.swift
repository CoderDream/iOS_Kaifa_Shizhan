//
//  ViewController.swift
//  CALayerTest
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 定义一个CALayer对象
    var birdLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 创建图层对象birdLayer
        self.birdLayer = CALayer()
        
        // 将图片加载到一个UIImage对象
        let image = UIImage(named: "Bird.png")
        
        // 设置图层birdLayer的内容
        self.birdLayer.contents = image?.cgImage
        // 设置图层birdLayer的内容布局方式（保持宽高比原样缩放）
        self.birdLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        // 设置图层birdLayer的边界
        self.birdLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        // 设置图层birdLayer的位置（视图中心）
        self.birdLayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        // 将图层birdLayer添加到当前视图（即view视图的支持图层）
        self.view.layer.addSublayer(self.birdLayer)        
    }


}

