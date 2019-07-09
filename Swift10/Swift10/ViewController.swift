//
//  ViewController.swift
//  Swift10
//
//  Created by 胡生才 on 2019/7/4.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupVideoBackground()
    }

    func setupVideoBackground() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
    }

}

