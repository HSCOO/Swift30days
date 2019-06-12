//
//  ViewController.swift
//  Swfit01
//
//  Created by 胡生才 on 2019/6/12.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pasueButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    // 定时器懒加载
    lazy var timer:Timer = {
        return Timer.init(timeInterval: 0.1, repeats: true, block: { _ in
            self.counter = self.counter + 0.1
        })
    }()
    
    var counter:Float = 0.0{
        // 属性监听
        didSet{
            secondLabel.text = String(format: "%.1f", counter)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerSetting()
        counter = 0.0
    }
    
    func timerSetting(){
        // 定时器添加到RunLoop中，并暂停
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        timer.fireDate = Date.distantFuture
    }

    @IBAction func resetClick(_ sender: UIButton) {
        sender.isEnabled = false
        playButton.isEnabled = true
        pasueButton.isEnabled = true
        
        counter = 0.0
        // 暂停定时器
        timer.fireDate = Date.distantFuture
    }
    
    @IBAction func playClick(_ sender: UIButton) {
        sender.isEnabled = false
        pasueButton.isEnabled = true
        // 继续定时器
        timer.fireDate = Date.distantPast
    }
    @IBAction func pauseClick(_ sender: UIButton) {
        sender.isEnabled = false
        playButton.isEnabled = true
        // 暂停定时器
        timer.fireDate = Date.distantFuture
    }
    
    deinit {
        timer.invalidate()
    }
}

