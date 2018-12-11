//
//  ViewController.swift
//  MusicPlayer
//
//  Created by CoderDream on 2018/12/11.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // 定义一个全局变量的播放器
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 读取本地音频文件
        let soundUrl = Bundle.main.url(forResource: "Maze", withExtension: "mp3")
        do {
            // 初始化播放器
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // 播放
    @IBAction func playAction(_ sender: UIButton) {
        audioPlayer?.play()
    }
    
    // 暂停
    @IBAction func pauseAction(_ sender: UIButton) {
        audioPlayer?.pause()
    }
 
    // 音量
    @IBAction func sliderAction(_ sender: Any) {
        let slider = sender as! UISlider
        audioPlayer?.volume = slider.value
    }
}

