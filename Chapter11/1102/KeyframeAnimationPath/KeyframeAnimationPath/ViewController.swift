//
//  ViewController.swift
//  KeyframeAnimationPath
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

//遵守CAAnimationDelegate协议
class ViewController: UIViewController, CAAnimationDelegate {
    
    var imageLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建图层对象ImageLayer
        self.imageLayer = CALayer()
        // 将图片加载到一个UIImage对象
        let image = UIImage(named: "Football.png")
        // 设置图层对象ImageLayer
        self.imageLayer.contents = image?.cgImage
        self.imageLayer.contentsGravity = CALayerContentsGravity.resizeAspect
        self.imageLayer.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.imageLayer.position = CGPoint(x: 150, y: 200)
        // 将图层ImageLayer添加到当前层
        self.view.layer.addSublayer(self.imageLayer)
    }
    
    // 点击屏幕触发事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 创建路径
        let starPath = CGMutablePath()
        starPath.move(to: CGPoint(x: 150, y: 200))
        starPath.addLine(to: CGPoint(x: 250, y: 200))
        starPath.addLine(to: CGPoint(x: 250, y: 300))
        starPath.addLine(to: CGPoint(x: 150, y: 300))
        // 闭合路径
        starPath.closeSubpath()
        
        // 创建位置变化的帧动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        // 设置动画持续时间为5秒
        animation.duration = 5
        // 设置self为动画代理对象
        animation.delegate = self
        // 设置动画路径
        animation.path = starPath
        // 设置动画结束时的处理方式（保持动画最后的状态）
        animation.fillMode = CAMediaTimingFillMode.forwards
        // 设置动画结束时是否移除（不移除）
        animation.isRemovedOnCompletion = false
        // 执行动画
        self.imageLayer.add(animation, forKey: "ImagePosition")
    }

}

