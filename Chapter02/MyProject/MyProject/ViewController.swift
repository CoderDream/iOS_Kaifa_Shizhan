//
//  ViewController.swift
//  MyProject
//
//  Created by coderdream on 2018/12/9.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var greetingLabel: UILabel!
    
    var nameString: String?
    
    @IBAction func changeWords(_ sender: UIButton) {
        // 用 nameString 属性（模型）保存用户输入信息
        nameString = self.nameTextField.text
        // 创建一个新的变了并将其设为视图控制器的 nameString 属性
        var name = nameString
        // 判断输入信息是否为空
        if(name?.isEmpty)! {
            name = "nice to meet you"
        }
        // 将拼接后的字符串信息显示在标签上
        self.greetingLabel.text = String(format: "%@, %@!", "Hi", name!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField {
            // 文本框放弃第一响应器状态
            textField.resignFirstResponder()
        }
        return true
    }
    
}

