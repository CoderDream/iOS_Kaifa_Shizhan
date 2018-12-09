//
//  RootViewController.swift
//  HelloWorld
//
//  Created by coderdream on 2018/12/9.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenWidth = UIScreen.main.bounds.width
        let labelWidth: CGFloat = 200
        // 创建一个标签对象
        let label = UILabel(frame: CGRect(x: (screenWidth - labelWidth)/2, y: 300, width: labelWidth, height: 50))
        // 让文本居中显示
        label.textAlignment = .center
        label.text = "Hello World!"
        // 设置字号和文本颜色
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
        label.textColor = UIColor.black
        // 添加标签对象到根视图
        self.view.addSubview(label)        
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
