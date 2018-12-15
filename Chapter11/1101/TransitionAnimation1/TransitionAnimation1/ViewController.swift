//
//  ViewController.swift
//  TransitionAnimation1
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

    // 点击屏幕粗发事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 过渡动画（缓出+从左向右翻转效果）
        UIView.transition(with: self.view, duration: 3, options: [.curveEaseOut, .transitionFlipFromLeft], animations: nil, completion: nil)
    }
}

