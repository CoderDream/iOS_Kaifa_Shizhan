//
//  RootViewController.swift
//  ThreeTabBar
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 初始化各个视图控制器
        let homeViewController = HomeViewController()
        let findViewController = FindViewController()
        let userViewController = UserViewController()
        // 调用封装方法
        self.addChildViewController(child: homeViewController, title: "首页", image: "home-icon")
        self.addChildViewController(child: findViewController, title: "发现", image: "find-icon")
        self.addChildViewController(child: userViewController, title: "我", image: "user-icon")
        
    }
    
    // 设置视图控制器标题以及 tabBarItem 属性
    func addChildViewController(child: UIViewController, title: String, image: String) {
        // 设置视图控制器标题
        child.title = title
        // 设置 tabBarItem 图片
        child.tabBarItem.image = UIImage.init(named: image)
        // 包装一个导航控制器
        let navViewController = UINavigationController(rootViewController: child)
        self.addChild(navViewController)
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
