//
//  ViewController.swift
//  BackgroundColorTest
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // 点击屏幕触发事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 背景颜色变化动画
        let animation = CAKeyframeAnimation(keyPath: "backgroundColor")
        // 设置每个关键帧对应的时间点
        animation.keyTimes = [0.0, 0.5, 1]
        // 设置每个关键帧上的backgroundColor值
        animation.values = [UIColor.white.cgColor, UIColor.green.cgColor, UIColor.red.cgColor]
        // 设置动画持续时间为3秒
        animation.duration = 3
        // 设置动画结束时的处理方式（保持动画最后的状态）
        animation.fillMode = CAMediaTimingFillMode.forwards
        // 设置动画结束时是否移除（不移除）
        animation.isRemovedOnCompletion = false
        // 执行动画
        self.view.layer.add(animation, forKey: "backgroundColor")
    }

}

