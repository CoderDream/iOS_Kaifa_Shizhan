//
//  ViewController.swift
//  AutoReverse
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //定义一个图片控件和两个按钮对象
    var ball: UIImageView!
    var startBtn: UIButton!
    var cancelBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 图片控件初始化
        self.ball = UIImageView(frame: CGRect(x: 30, y: 130, width: 100, height: 100))
        // 设置图片控件要显示的图片
        self.ball.image = UIImage(named: "Glassball.png")
        // 将图片控件加载到当前视图
        self.view.addSubview(ball)
        
        // “往返10次”按钮初始化
        self.startBtn = UIButton(type: .system)
        startBtn.setTitle("往返10次", for: .normal)
        startBtn.frame = CGRect(x: 55, y: 320, width: 100, height: 40)
        // 为“往返10次”按钮添加点击事件
        startBtn.addTarget(self, action: #selector(clickStart), for: .touchUpInside)
        //将“往返10次”按钮加载到当前视图
        self.view.addSubview(startBtn)
        
        // “停止往返”按钮初始化
        self.cancelBtn = UIButton(type: .system)
        cancelBtn.setTitle("停止往返", for: .normal)
        cancelBtn.frame = CGRect(x: 220, y: 320, width: 100, height: 40)
        // 为“停止往返”按钮添加点击事件
        cancelBtn.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        // 将“停止往返”按钮加载到当前视图
        self.view.addSubview(cancelBtn)
    }

    @objc func clickStart(_ sender: Any) {
        // 动画开始，“往返10次”按钮变为不可用
        self.startBtn.isUserInteractionEnabled = false
        // 获取玻璃球起始点的x坐标
        let xorig = CGFloat(self.ball.center.x)
        // 自动往返属性变量
        let opts: UIView.AnimationOptions = UIView.AnimationOptions.autoreverse
        // 玻璃球水平往返动画（重复10遍，动画结束时玻璃球返回起始点，同时“往返10次”按钮变为可用）
        UIView.animate(withDuration: 1, delay: 0, options: opts, animations: {
            UIView.setAnimationRepeatCount(10)
            self.ball.center.x += 220
        }, completion: { _ in
            self.ball.center.x = xorig
            // 动画结束，“往返10次”按钮又变为可用
            self.startBtn.isUserInteractionEnabled = true
        })
    }
    
    @objc func clickCancel(_ sender: Any) {
        // 动画开始，“往返10次”按钮变为可用
        self.startBtn.isUserInteractionEnabled = true
        // 获取玻璃球返回起始点
        self.ball.layer.position = self.ball.layer.presentation()!.position
        // 动画结束
        self.ball.layer.removeAllAnimations()
    }

}

