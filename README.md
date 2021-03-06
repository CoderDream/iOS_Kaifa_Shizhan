# iOS_Kaifa_Shizhan
iOS开发实战


iOS开发实战（双色）

[http://www.bjjqe.com/detail_book.php?gid=1406](http://www.bjjqe.com/detail_book.php?gid=1406)

ISBN:978-7-5165-1549-5

作者：李兆延 李俊 张焕国

定价：88.00元

出版社：航空工业出版社

适用层次：通用

购买 下载资料 下载样张
图书简介
本书基于iOS 11 + Xcode 9平台，全面介绍了利用Swift 4编程语言开发iOS应用所需要的关键技术，涵盖了应用从开发到上架的全过程。

全书分13章，内容包括iOS开发准备、iOS基本开发流程、基础UI控件、高级UI控件、多线程编程、网络编程、多媒体和硬件、定位服务和地图应用、屏幕适配、数据持久化、动画技术、项目设置与发布、开发实践——上班签到App等。

本书可作为计算机及相关专业的教材，也可作为移动应用开发人员的参考读物。

图书目录

第1章  iOS开发准备

1.1  iOS概述

1.1.1  iOS的产生与发展

1.1.2  iOS 11的新特性

1.2  iOS开发语言

1.2.1  Objective-C简介

1.2.2  Swift简介

1.3  搭建iOS开发环境

1.3.1  Xcode简介

1.3.2  安装Xcode 9

1.4  创建第一个iOS应用

1.5  iOS系统的架构层次

本章小结

思考与练习

 

第2章  iOS基本开发流程

2.1  iOS的框架与设计模式

2.1.1  iOS的主要框架

2.1.2  iOS中常用的设计模式

2.2  应用程序的开发流程

2.2.1  创建MyProject项目

2.2.2  配置视图

2.2.3  实施视图控制器

2.3  应用程序的测试与发布

2.3.1  使用模拟器测试应用程序

2.3.2  使用iOS设备测试应用程序

```
(lldb) po self.nameTextField.text
▿ Optional<String>
  - some : "Tom"
```

(lldb) 2.3.3  发布应用程序到App Store

本章小结

思考与练习

 

第3章  基础UI控件

3.1  视图控制器和视图

3.1.1  视图控制器

3.1.2  视图UIView

3.2  常用的界面构建方式

3.2.1  使用故事板构建界面

3.2.2  使用XIB构建界面

3.2.3  使用纯代码构建界面

3.2.4  3种界面构建方式的比较

3.3  常用视图控件的用法

3.3.1  标签控件（UILabel）和图片控件（UIImageView）

3.3.2  按钮控件（UIButton）

3.3.3  文本框控件（UITextField）和文本视图控件（UITextView）

案例3-1：创建一个登录程序

本章小结

思考与练习

 

第4章  高级UI控件

4.1  导航控制器（UINavigationController）

4.1.1  导航控制器的工作原理

4.1.2  导航控制器的组成

案例4-1：使用导航控制器构建界面

4.2  标签控制器（UITabBarController）

4.2.1  标签控制器的工作原理

4.2.2  标签控制器的组成

案例4-2：使用标签控制器构建界面

```swift
// 实例化 window 属性，并设置它的大小为当前屏幕大小
self.window = UIWindow(frame: UIScreen.main.bounds)
// 将 RoowViewController 的对象赋值给 window 的 rootViewController
self.window?.rootViewController = RootViewController()
self.window?.backgroundColor = UIColor.white
// 显示程序窗口
self.window?.makeKeyAndVisible()
```

4.3  滚动视图（UIScrollView）

4.3.1  滚动视图的常用属性

4.3.2  滚动视图的代理方法

案例4-3：使用滚动视图实现无限循环轮播图

4.4  表视图（UITableView）

4.4.1  表视图的基本组成

4.4.2  表视图的两种类型

4.4.3  表视图中单元格的组成和样式

4.4.4  表视图的数据源协议和代理协议

案例4-4：使用表视图实现图书列表展示

```shell
Treating a forced downcast to 'BookModel' as optional will never produce 'nil'
```

4.5  网页视图（UIWebView）

本章小结

思考与练习

 

第5章  多线程编程

5.1  多线程简介

5.1.1  进程和线程的概念

5.1.2  iOS的3种多线程技术

5.2  使用Thread实现多线程

5.2.1  Thread的创建方法

5.2.2  Thread的其他使用方法

5.3  Operation和OperationQueue

5.3.1  BlockOperation

5.3.2  OperationQueue

5.4  使用GCD实现多线程

5.4.1  GCD中几个重要的概念

5.4.2  GCD线程队列

4种队列组合

 - 1）同步+串行队列

```swift

 func sync_serial() {
     //创建一个串行队列
     let serialQueue = DispatchQueue(label: "serial", attributes: .init(rawValue: 0))
     //同步执行三个任务
     serialQueue.sync {
        print("1 + \(Thread.current)")
     }
     serialQueue.sync {
        print("2 + \(Thread.current)")
     }
     serialQueue.sync {
        print("3 + \(Thread.current)")
     }
 }
 sync_serial()
```

- 执行结果：

```
<NSThread: 0x282f19c40>{number = 3, name = (null)}
<NSThread: 0x282f1cbc0>{number = 4, name = (null)}
<NSThread: 0x282f19a80>{number = 5, name = (null)}
1 + <NSThread: 0x282f42dc0>{number = 1, name = main}
2 + <NSThread: 0x282f42dc0>{number = 1, name = main}
3 + <NSThread: 0x282f42dc0>{number = 1, name = main}
<NSThread: 0x282f42dc0>{number = 1, name = main}
```

- 2）异步+串行队列

```swift
func async_serial() {
	//创建一个串行队列
	let serialQueue = DispatchQueue(label: "serial", attributes: .init(rawValue: 0))
	//异步执行三个任务
	serialQueue.async {
		print("1 + \(Thread.current)")
	}
	serialQueue.async {
		print("2 + \(Thread.current)")
	}
	serialQueue.async {
		print("3 + \(Thread.current)")
	}
}
```
- 执行结果

```swift
<NSThread: 0x2820feb40>{number = 3, name = (null)}
<NSThread: 0x2820feec0>{number = 4, name = (null)}
<NSThread: 0x2820e6100>{number = 5, name = (null)}
<NSThread: 0x2820b6f80>{number = 1, name = main}
1 + <NSThread: 0x2820e4480>{number = 6, name = (null)}
2 + <NSThread: 0x2820e4480>{number = 6, name = (null)}
3 + <NSThread: 0x2820e4480>{number = 6, name = (null)}
```

- 3）同步+并发队列

```swift
func sync_concurrent() {
    //创建一个全局队列
    let globalQueue = DispatchQueue.global()
    //同步执行三个任务
    globalQueue.sync {
        print("1 + \(Thread.current)")
    }
    globalQueue.sync {
        print("2 + \(Thread.current)")
    }
    globalQueue.sync {
        print("3 + \(Thread.current)")
    }
}
sync_concurrent()
```
- 执行结果

```
<NSThread: 0x281150b40>{number = 3, name = (null)}
<NSThread: 0x281150c80>{number = 4, name = (null)}
<NSThread: 0x281151600>{number = 5, name = (null)}
1 + <NSThread: 0x281105e00>{number = 1, name = main}
2 + <NSThread: 0x281105e00>{number = 1, name = main}
3 + <NSThread: 0x281105e00>{number = 1, name = main}
<NSThread: 0x281105e00>{number = 1, name = main}
```

- 4）异步+并发队列

```swift
func async_concurrent() {
    //创建一个全局队列
    let globalQueue = DispatchQueue.global()
    //异步执行三个任务
    globalQueue.async {
        print("1 + \(Thread.current)")
    }
    globalQueue.async {
        print("2 + \(Thread.current)")
    }
    globalQueue.async {
        print("3 + \(Thread.current)")
    }
}
async_concurrent()
```
- 执行结果

```
<NSThread: 0x2812a1480>{number = 5, name = (null)}
<NSThread: 0x2812a0e40>{number = 4, name = (null)}
<NSThread: 0x2812a0f00>{number = 3, name = (null)}
<NSThread: 0x2812f9d40>{number = 1, name = main}
2 + <NSThread: 0x2812a0d00>{number = 7, name = (null)}
3 + <NSThread: 0x2812a0d00>{number = 7, name = (null)}
1 + <NSThread: 0x2812a1a00>{number = 6, name = (null)}
```

案例5-1：使用多线程模拟火车票售票系统

本章小结

思考与练习

 

第6章  网络编程

6.1  网络编程的基本概念

6.1.1  网络请求

6.1.2  网络协议

6.1.3  JSON数据格式

6.2  使用URLSession进行网络请求

6.2.1  URLSession简介

6.2.2  实现GET和POST请求

6.2.3  用URLSession请求网络数据

6.3  使用CocoaPods管理第三方库

6.3.1  安装CocoaPods工具

6.3.2  在项目中使用CocoaPods

6.4  使用Alamofire进行网络请求

本章小结

思考与练习

 

第7章  多媒体和硬件

7.1  播放音频文件

7.2  播放视频文件

7.2.1  AVPlayer类简介

7.2.2  用AVPlayer播放视频

7.3  使用相机和照片图库

7.3.1  UIImagePickerController类简介

7.3.2  用UIImagePickerController获取图片

本章小结

思考与练习

 

第8章  定位服务和地图应用

8.1  定位服务

8.1.1  实现定位服务

8.1.2  地理信息编码与反编码

8.2  地图应用

8.2.1  显示地图

8.2.2  添加标注点

本章小结

思考与练习

 

第9章  屏幕适配

9.1  屏幕适配的历史背景

9.2  Autoresizing布局技术

9.3  Auto Layout布局技术

9.3.1  在Interface Builder中管理AutoLayout约束

9.3.2  使用Auto Layout布局

本章小结

思考与练习

 

第10章  数据持久化

10.1  应用程序的沙盒

10.2  用属性列表实现数据持久化

10.3  用对象归档实现数据持久化

10.4  用SQLite数据库实现数据持久化

10.4.1  添加SQLite 3动态库

10.4.2  导入SQLite 3头文件

10.4.3  使用SQLite 3数据库

10.4.4  创建SQLite应用程序

10.5  用Core Data实现数据持久化

10.5.1  添加Core Data支持

10.5.2  理解Core Data栈

10.5.3  设计数据模型

10.5.4  创建Core Data应用程序

本章小结

思考与练习

 

第11章  动画技术

11.1  UIView动画

11.1.1  动画闭包

11.1.2  动画附加选项

11.1.3  创建过渡动画

11.2  Core Animation动画

11.2.1  图层（CALayer）

11.2.2  动画基类（CAAnimation）

11.2.3  属性动画（CAPropertyAnimation）

11.2.4  用路径创建关键帧动画

11.2.5  过渡动画（CATransition）

本章小结

思考与练习

 

第12章  项目设置与发布

12.1  申请开发者账号

12.2  应用程序收尾设置

12.2.1  设置图标

12.2.2  设置启动画面

12.2.3  设置标识、签名和部署信息

12.3  创建生产证书、App ID和描述文件

12.3.1  创建生产证书

12.3.2  创建App ID

12.3.3  创建描述文件

12.4  应用程序的打包与发布

12.4.1  在iTunes Connect中创建和配置应用

12.4.2  使用Xcode打包和上传应用

12.4.3  在iTunes Connect中提交审核

本章小结

思考与练习


- [第13章  开发实践——上班签到App](Chapter13/)  


 

参考文献