//
//  ViewController.swift
//  TwoNavigation
//
//  Created by coderdream on 2018/12/9.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "First"
    }

    @IBAction func pushViewController(_ sender: UIButton) {
        // 跳转到 SecondViewController
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}

