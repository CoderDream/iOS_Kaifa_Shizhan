//
//  RootViewController.swift
//  SlideShow
//
//  Created by CoderDream on 2018/12/10.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    // 获取屏幕的高和宽
    let kScreenWidth = UIScreen.main.bounds.width
    let kScreenHeight = UIScreen.main.bounds.height
    let imageCount = 4
    var scrollView: UIScrollView!
    var pageView: UIPageControl!        // 分页控制器
    var timer: Timer!                   // 定时器
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // 初始化 UI 控件
        setupViews()
        
        // 添加定时器
        addTimer()
    }
    
    
    // 添加UI控件
    func setupViews() {
        // 不允许视图控制器自动调整 scrollView 的位置
        if #available(iOS 11.0, *) {
            scrollView?.contentInsetAdjustmentBehavior = .never
        } else {
            // contentInsetAdjustmentBehavior
            automaticallyAdjustsScrollViewInsets = false
            // scrollView?.contentInsetAdjustmentBehavior = false
        }
        
        do {
            // 初始化滚动视图
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            
            // 将代理设置为视图控制器本身
            scrollView.delegate = self
            
            view.addSubview(scrollView)
        }
        
        do {
            // 初始化分页控制器
            pageView = UIPageControl(frame: CGRect(x: 0, y: kScreenHeight - 30, width: kScreenWidth, height: 30))
            view.addSubview(pageView)
            pageView.numberOfPages = imageCount                     // 设置分页数目
            pageView.currentPage = 0                                // 设置当前显示页
            pageView.pageIndicatorTintColor = UIColor.white         // 设置未显示的圆圈颜色
            pageView.currentPageIndicatorTintColor = UIColor.blue   // 设置已显示的圆圈颜色
        }
        
        do {
            // 只使用 3 个 UIImageView，依次设置好最后一张、第一张、第二张图片，这里面使用取模运算
            for index in 0 ..< 3 {
                let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
                let named = "\((index + 3) % 4).png"
                imageView.image = UIImage(named: named)
                scrollView.addSubview(imageView)
            }
        }
        
        do {
            // 设置有关滚动视图的属性
            scrollView.contentSize = CGSize(width: kScreenWidth * 3, height: 0)
            scrollView.contentOffset = CGPoint(x: kScreenWidth, y: 0)
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
        }
        
    }
    
    // 下一张图片
    func nextImage() {
        if pageView.currentPage == imageCount - 1 {
            pageView.currentPage = 0
        } else {
            pageView.currentPage += 1
        }
        let contentOffset = CGPoint(x: kScreenWidth * 2, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    
    // 上一张图片
    func preImage() {
        if pageView.currentPage == 0 {
            pageView.currentPage = imageCount - 1
        } else {
            pageView.currentPage -= 1
        }
        let contentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    // 重新加载图片，重新设置 3 个 UIImageView
    func reloadImage() {
        let currentIndex = pageView.currentPage
        let nextIndex = (currentIndex + 1) % 4
        let preIndex = (currentIndex + 3) % 4
        (scrollView.subviews[0] as! UIImageView).image = UIImage(named: "\(preIndex).png")
        (scrollView.subviews[1] as! UIImageView).image = UIImage(named: "\(currentIndex).png")
        (scrollView.subviews[2] as! UIImageView).image = UIImage(named: "\(nextIndex).png")
    }
    
    // 添加 timer
    func addTimer() {
        // 初始化定时器，每隔 2s 调用一次 nextImage() 方法
        timer = Timer(timeInterval: 2, repeats: true, block: {[weak self] _ in
            self?.nextImage()
        })
        
        // 如果定时器为空，则返回
        guard let timer = timer else {
            return
        }
        
        // 将 timer 添加到 RunLoop 的 commonModes 中
        RunLoop.current.add(timer, forMode: .common)
    }
    
    // 移除 timer
    func removeTimer() {
        timer?.invalidate()
        timer = nil
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

extension RootViewController: UIScrollViewDelegate {
    // 当停止滚动的时候，重新设置三个 UIImageView 的内容，然后显示中间那个 UIImageView
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
        scrollView.setContentOffset(CGPoint(x: kScreenWidth, y: 0), animated: false)
    }
    
    // 停止拖拽，开始 Timer，并且判断是显示上一张图片还是下一张图片
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
        if scrollView.contentOffset.x < kScreenWidth {
            preImage()
        } else {
            nextImage()
        }
    }
    
    // 开始滑动的时候，停止 timer，设置为 niltimer 才会销毁
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
}
