//
//  ViewController.swift
//  VideoPlayer
//
//  Created by CoderDream on 2018/12/11.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // 播放器容器
    @IBOutlet weak var containerView: UIView!
    // 播放/暂停按钮
    @IBOutlet weak var playOrPauseButton: UIButton!
    // 播放进度
    @IBOutlet weak var progress: UIProgressView!
    // 显示播放时间
    @IBOutlet weak var timeLabel: UILabel!
    // 播放器对象
    var player: AVPlayer?
    // 播放资源对象
    var playerItem: AVPlayerItem?
    // 时间观察者
    var timeObserver: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // 初始化数据
    func addPlayToAVPlayerLayer() {
        // 获取本地视频资源
        guard let path = Bundle.main.path(forResource: "Transformers5", ofType: ".mp4") else {
            return
        }
        // 播放本地视频
        let url = NSURL(fileURLWithPath: path)
        // 播放网络视频，只需将path替换为视频资源的网络地址即可
        //let url = NSURL(string: path)!
        playerItem = AVPlayerItem(url: url as URL)
        player = AVPlayer(playerItem: self.playerItem)

        // 创建视频播放器图层对象
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        // 视频填充模式
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        containerView.layer.addSublayer(playerLayer)
        
        addProgressObserver()
        addObserver()
    }
    
    
    //给播放器添加进度更新
    func addProgressObserver() {
        // 这里设置每秒执行一次
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: Int64(1.0), timescale: Int32(1.0)), queue: DispatchQueue.main) { [weak self] (time: CMTime) in
            // CMTimeGetSeconds函数将CMTime转换为秒，如果CMTime无效，将返回NaN
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds(self!.playerItem!.duration)
            // 更新显示的时间和进度条，当前播放时间/总时间
            let times = String(format: "%@/%@", self!.formatPlayTime(seconds: currentTime), (self?.formatPlayTime(seconds: totalTime))!)
            self?.timeLabel.text = times
            self!.progress.setProgress(Float(currentTime/totalTime), animated: true)
            print("当前已经播放 \(self!.formatPlayTime(seconds: CMTimeGetSeconds(time)))")
        }
    }
    
    // 将秒转成时间字符串，将这个方法单独封装，便于多
    func formatPlayTime(seconds: Float64) -> String {
        let min = Int(seconds / 60)
        // 取余
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", min, sec)
    }
    
    // 计算当前的缓冲进度，在播放网络视频时常用到此方法
    func availableDurationWithPlayerItem() -> TimeInterval {
        guard let loadedTimeRanges = player?.currentItem?.loadedTimeRanges, let first = loadedTimeRanges.first else {
            fatalError()
        }
        let timeRange = first.timeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange.start)
        let durationSeconds = CMTimeGetSeconds(timeRange.duration)
        let result = startSeconds + durationSeconds
        return result
    }
    
    //为AVPlayerItem和AVPlayer添加监控
    func addObserver() {
        // 为 AVPlayerItem 添加 status 属性观察，得到资源准备好，开始播放视频
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        // 监听 AVPlayerItem 的 loadedTimeRanges 属性来监听缓冲进度更新，用于播放网络视频
        playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.playerItemDidReachEnd(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    //播放结束，回到最开始位置，按钮显示“播放”
    @objc func playerItemDidReachEnd(notification: Notification) {
        player?.seek(to: CMTime.zero, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        progress.progress = 0.0
        playOrPauseButton.setTitle("播放", for: .normal)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let object = object as? ACPl
    }
}

