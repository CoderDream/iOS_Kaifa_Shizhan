//
//  ViewController.swift
//  MyCamera
//
//  Created by CoderDream on 2018/12/12.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // 图片选择控制器
    var imagePicker: UIImagePickerController!
    // 图片视图
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 照片
    @IBAction func imagePickerBtnAction(_ sender: Any) {
        // 照片图库是否可用
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            if self.imagePicker == nil {
                self.imagePicker = UIImagePickerController()
            }
            self.imagePicker.delegate = self
            // 设置图片来源为设备的照片图库
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            // 弹出警告框
            let errorAlert = UIAlertController(title: "照片图库不可访问", message: "", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.cancel, handler: nil)
            errorAlert.addAction(cancelAction)
            self.present(errorAlert, animated: true, completion: nil)
        }
    }    
    
    // 相机
    @IBAction func cameraBtnCliked(_ sender: Any) {
        // 相机是否可用
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            if self.imagePicker == nil {
                self.imagePicker = UIImagePickerController()
            }
            self.imagePicker.delegate = self
            // 设置图片来源为相机
            self.imagePicker.sourceType = .camera
            // 允许拍摄图片后编辑
            imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            // 弹出警告框
            let errorAlert = UIAlertController(title: "相机不可用", message: "", preferredStyle: UIAlertController.Style.alert)
            let cancelAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.cancel, handler: nil)
            errorAlert.addAction(cancelAction)
            self.present(errorAlert, animated: true, completion: nil)
        }
    }

    // 实现UIImagePickerControllerDelegate的代理方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let type: String = (info[UIImagePickerController.InfoKey.mediaType] as! String)
        // 当选择的类型是图片时
        if type == "public.image" {
            let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            // 将获取到的图片放到图片控件上
            self.imageView.image = img
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.didReceiveMemoryWarning()
    }

}

