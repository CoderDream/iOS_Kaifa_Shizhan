//
//  ViewController.swift
//  UserLogin
//
//  Created by coderdream on 2018/12/9.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 设置文本框代理
        self.accountTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    // 实现 TextField 的代理方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 指示文本栏放弃第一响应器的状态
        textField.resignFirstResponder()
        return true
    }

    // 按钮的点击事件
    @IBAction func loginBtnAction(_ sender: UIButton) {
        var message: String?
        // 判断账号和密码是否为空
        if !(self.accountTextField.text?.isEmpty)! && !(self.passwordTextField.text?.isEmpty)! {
            message = "登录成功"
        } else if (self.accountTextField.text?.isEmpty)! {
            message = "请输入一个账号信息"
        } else if (self.passwordTextField.text?.isEmpty)! {
            message = "请输入密码"
        }
        
        // 创建一个警告控制器
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(ok)
        // 展示警告控制器
        self.present(alert, animated: true, completion: nil)
    }
}

