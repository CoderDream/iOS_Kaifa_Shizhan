//
//  ViewController.swift
//  CABasicAnimationTest
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建图层对象ImageLayer
        self.imageLayer = CALayer()
        // 将图片加载到一个UIImage对象
        let image = UIImage(named: "Taiji.png")
        // 设置图层对象ImageLayer
        self.imageLayer.contents = image?.cgImage
        self.imageLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        self.imageLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        self.imageLayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        // 将图层ImageLayer添加到当前层
        self.view.layer.addSublayer(self.imageLayer)
    }
    
    // 点击屏幕触发事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 绕z轴旋转动画
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        // 从0度开始
        animation.fromValue = 0
        // 旋转到360度
        animation.toValue = Double.pi * 2
        // 持续时间为2秒
        animation.duration = 2
        // 执行动画
        self.imageLayer.add(animation, forKey: "ImageRotate")
    }

}

