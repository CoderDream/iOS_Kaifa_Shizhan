//
//  ViewController.swift
//  UIChange
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


    @IBAction func changeBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 2, animations: { () -> Void in
            self.view.backgroundColor = UIColor.yellow      // view 视图变成黄色
            self.view.center.x += 50                        // view 视图右移 50
            self.view.center.y += 80                        // view 视图下移 80
        })
    }
}

