//
//  ViewController.swift
//  CATransitionTest
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageLayer: CALayer!
    var image: UIImage!
    //图层要显示的图片的名称变量
    var imgName = "Elephant.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建图层对象ImageLayer
        self.imageLayer = CALayer()
        
        //设置并加载图层对象ImageLayer
        self.image = UIImage(named: imgName)
        self.imageLayer.contents = image?.cgImage
        self.imageLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        self.imageLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        self.imageLayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        self.view.layer.addSublayer(self.imageLayer)
    }
    
    //点击屏幕触发事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //创建过渡动画
        let animation = CATransition()
        //设置动画持续时间为3秒
        animation.duration = 3
        //设置type属性
        animation.type = CATransitionType.push
        //设置subtype属性
        animation.subtype = CATransitionSubtype.fromRight
        //执行动画
        self.imageLayer.add(animation, forKey: "transition")
        
        //移除图层对象ImageLayer
        self.imageLayer.removeFromSuperlayer()
        //轮流切换要显示图片的名称
        imgName = (imgName == "Panda.png") ? "Elephant.png" : "Panda.png"
        //重新设置并加载图层对象ImageLayer
        self.image = UIImage(named: imgName)
        self.imageLayer.contents = image?.cgImage
        self.imageLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        self.imageLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        self.imageLayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        self.view.layer.addSublayer(self.imageLayer)
    }
}

