//
//  ViewController.swift
//  BookTable
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 通过 xib 关联表视图
    @IBOutlet weak var myTableView: UITableView!
    
    // 定义一个存放数据模型的数组
    var dataArray: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 初始化数组
        dataArray = NSMutableArray()
        // 从 BookList.plist 文件中读取数据
        for bookDict in NSArray(contentsOfFile: Bundle.main.path(forResource: "BookList", ofType: "plist")!)! {
            let bookModel = BookModel()
            // 通过 KVC  方法将数据赋值给模型
            bookModel.setValuesForKeys(bookDict as! Dictionary)
            // 将存放了数据的模型添加到数组中
            dataArray.add(bookModel)
        }
        
        // 设置表视图的数据源和代理为当前视图控制器 (self 指代当前控制器）
        myTableView.dataSource = self
        myTableView.delegate = self
        
        // 设置表视图的表脚视图
        myTableView.tableFooterView = UIView()
    }


}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // 返回表视图的节数
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 返回节的行数
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 定义 cell 标识
        let cellID = "bookCell"
        // 从表视图的缓存池取出带有 cellID 标识的 cell
        var bookCell: BookCell? = tableView.dequeueReusableCell(withIdentifier: cellID) as? BookCell
        
        // 如果取出的 cell 为空
        if bookCell == nil {
            // 从 xib 文件中加载视图
            bookCell = Bundle.main.loadNibNamed("BookCell", owner: self, options: nil)?.last as? BookCell
            // 从数组中取出存数据的模型
            let bookModel: BookModel! = dataArray[indexPath.row] as! BookModel
            // 将模型传到 cell 中，在 cell 中进行赋值
            bookCell?.configWithBookModel(bookModel: bookModel!)
        }
        
        return bookCell!
    }
    
    // 设置单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
