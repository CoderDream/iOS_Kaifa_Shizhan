//
//  ViewController.swift
//  TransitionAnimation2
//
//  Created by coderdream on 2018/12/15.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 定义两个视图对象
    var view1: UIView!
    var view2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 初始化view1视图，并加载
        self.view1 = UIView(frame: CGRect(x: 20, y: 20, width: 335, height: 627))
        self.view1.backgroundColor = UIColor.red
        self.view.addSubview(view1)
        // 初始化view2视图，但不加载
        self.view2 = UIView(frame: CGRect(x: 20, y: 20, width: 335, height: 627))
        self.view2.backgroundColor = UIColor.blue
    }
    
    // 点击屏幕粗发事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 过渡动画（缓出+从下往上卷翻页效果）
        UIView.transition(from: view1, to: view2, duration: 3, options: [.curveEaseOut, .transitionCurlUp], completion: nil)
    }
}
