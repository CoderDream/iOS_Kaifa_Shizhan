//
//  RootViewController.swift
//  LabelImageView2
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
        let imageWidth: CGFloat = 300
        // 创建一个标签对象
        let catImage = UIImageView(frame: CGRect(x: (screenWidth - imageWidth)/2, y: 60, width: imageWidth, height: 300))
        // 给图片控件设置名为"cat"的图片
        catImage.image = UIImage.init(named: "cat")
        self.view.addSubview(catImage)
        
        // 创建一个标签对象
        let label = UILabel(frame: CGRect(x: catImage.frame.origin.x,  y: 385, width: imageWidth, height: 55))
        
        // 让文本居中显示
        label.text = "碰见一只喜欢看打麻将的猫，这眼神简直像个指挥官！"
        // 设置字号和文本颜色
        label.textColor = UIColor.white
        // 默认为1.设置为0，表示不限制行数
        label.numberOfLines = 0
        label.backgroundColor = UIColor.darkGray
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
