//
//  TableViewController.swift
//  Clockin
//
//  Created by coderdream on 2018/12/16.
//  Copyright © 2018 coderdream. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    // 定义一个变量数组
    var staff = [NSManagedObject]()
    // 定义可重用单元格标识符
    let cellIdentifier = "reuseIndentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册表视图单元格
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        //设置表视图背景颜色
        tableView.backgroundColor = UIColor.init(red: 98/255, green: 198/255, blue: 255/255, alpha: 1)
        //不显示单元格分界线
        tableView.separatorStyle = .none

        
        // 注册表视图单元格
        //tableView.register

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //获取代理和托管对象
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        //建立请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        //执行请求
        do {
            let fetchedResults = try managedObectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                staff = results
                
                tableView.reloadData()
            }
        } catch  {
            fatalError("获取失败")
        }
    }
    
    @IBAction func addName(_ sender: Any) {
        //创建一个对话框（即可输入文本的警告框）
        let alert = UIAlertController(title: "登录验证", message: "请输入您的姓名", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
        }
        
        //如果点击对话框的“确定”按钮
        let saveAction = UIAlertAction(title: "确定", style: .default) { (action: UIAlertAction!) in
            let textField = alert.textFields![0] as UITextField
            //获取当前时间
            let now = Date()
            //创建一个日期格式器
            let dformatter = DateFormatter()
            //dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
            dformatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
            //将名字和当前日期进行拼接，并保存数据
            let newname = String(format: "🆔 %@     %@", textField.text!, dformatter.string(from: now))
            self.saveName(text: newname)
            //表视图显示新添加的数据
            let indexPath = IndexPath(row: self.staff.count - 1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        //如果点击对话框的“取消”按钮
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action: UIAlertAction) in
            //不执行任何操作
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //弹出警告框
        present(alert, animated: true, completion: nil)

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return staff.count
    }
    
    //为单元格提供数据
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //通过可重用标识符获得可重用单元格对象
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        //获取单元格内容
        let person = staff[indexPath.row]
        cell.textLabel?.text = person.value(forKey: "name") as? String
        //设置单元格的字体颜色和背景颜色
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.init(red: 98/255, green: 198/255, blue: 255/255, alpha: 1)
        
        return cell
    }
    
    //保存数据
    private func saveName(text: String) {
        //获取代理和托管对象
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObectContext = appDelegate.persistentContainer.viewContext
        
        //建立一个实体entity
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedObectContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedObectContext)
        
        //保存文本框中的值到person数组
        person.setValue(text, forKey: "name")
        
        //保存entity到托管对象中。如果保存失败，进行处理
        do {
            try managedObectContext.save()
        } catch  {
            fatalError("无法保存")
        }
        //保存到数组中，更新UI
        staff.append(person)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // 设置删除按钮的标题
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    // 删除数据
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
     
        if editingStyle == .delete {
            //获取代理和托管对象
            let app = UIApplication.shared.delegate as! AppDelegate
            let contexts = app.persistentContainer.viewContext
            let entityName = "Person"
            //建立请求
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
            fetchRequest.fetchLimit = 10
            fetchRequest.fetchOffset = 0
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: contexts)
            fetchRequest.entity = entity
            //设置查询条件
            let person = staff[indexPath.row]
            let del = person.value(forKey: "name") as? String
            let predicate = NSPredicate.init(format: "name = %@", del!)
            fetchRequest.predicate = predicate
            //查询并删除数据
            do {
                let fetchedObjects = try contexts.fetch(fetchRequest) as! [Person]
                for one: Person in fetchedObjects {
                    contexts.delete(one)
                    app.saveContext()
                }
            } catch {
                let nserror = error as NSError
                fatalError("查询错误： \(nserror), \(nserror.userInfo)")
            }
            //刷新表视图，更新UI
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObectContext = appDelegate.persistentContainer.viewContext
            let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            do {
                let fetchedResults = try managedObectContext.fetch(fetchRequest1) as? [NSManagedObject]
                if let results = fetchedResults {
                    staff = results
                    tableView.reloadData()
                }
            } catch {
                fatalError("获取失败")
            }
        }

     
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
