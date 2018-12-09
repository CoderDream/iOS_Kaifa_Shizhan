//
//  SecondViewController.swift
//  TwoNavigation
//
//  Created by coderdream on 2018/12/9.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Second"
        self.view.backgroundColor = UIColor.yellow
        // 新建一个导航栏按钮
        let leftBarButton = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(popViewController))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
 
    // 返回到上一级界面
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
