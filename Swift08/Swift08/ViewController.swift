//
//  ViewController.swift
//  Swift08
//
//  Created by 胡生才 on 2019/6/28.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    lazy var audioPlayer: AVAudioPlayer = {
        var player = AVAudioPlayer()
        
        let music = URL(fileURLWithPath: Bundle.main.path(forResource: "Ecstasy", ofType: "mp3")!)
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            try player = AVAudioPlayer(contentsOf: music)
        }
        catch let audioError as NSError{
            print(audioError)
        }
        
        return player
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        return layer
    }()
    
    lazy var timer: Timer = {
        let timer = Timer.init(timeInterval: 0.2, repeats: true
            , block: { _ in
                // 只有播放中才改变颜色，播放结束就暂停定时器
                if (self.audioPlayer.isPlaying){
                    self.randomBackgroundColor()
                }
                else{
                    self.timer.fireDate = Date.distantFuture
                }
        })
        return timer
    }()
    
    var backgroundColor:(red: CGFloat, green: CGFloat, blue: CGFloat,alpha: CGFloat)!{
        didSet{
            let color = UIColor(red: backgroundColor.blue, green: backgroundColor.green, blue: 0, alpha: backgroundColor.alpha).cgColor
            let otherColor = UIColor(red: backgroundColor.red, green: backgroundColor.green, blue: backgroundColor.blue, alpha: backgroundColor.alpha).cgColor
            gradientLayer.colors = [color, otherColor]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 设置定时器
        RunLoop.current.add(timer, forMode: .common)
        timer.fireDate = Date.distantFuture
    }

    @IBAction func playAudio(_ sender: Any) {
        
        guard !self.audioPlayer.isPlaying else {
            // 播放中，再次点击，就暂停
            
            // 暂停定时器
            timer.fireDate = Date.distantFuture
            audioPlayer.pause()
            return
        }
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        // 开启定时
        timer.fireDate = Date.distantPast
        
        // 随机背景颜色
        view.backgroundColor = randomColor()
        
        // 添加渐变色在最底层，避免挡住按钮
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func randomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }
    
    func randomBackgroundColor() {
        let redValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        backgroundColor = (redValue, blueValue, greenValue, 1)
    }
}

