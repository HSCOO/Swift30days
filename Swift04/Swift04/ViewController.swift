//
//  ViewController.swift
//  Swift04
//
//  Created by 胡生才 on 2019/6/17.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var screenWidth = {
        return UIScreen.main.bounds.size.width
    }()
    
    lazy var screenHeight = {
        return UIScreen.main.bounds.size.height
    }()

   lazy var scrollView:UIScrollView = {
        let rect = UIScreen.main.bounds
        let scroll = UIScrollView(frame: rect)
    
        let size = rect.size
        let width = size.width
        let height = size.height
    
        scroll.contentSize = CGSize.init(width: width * 3, height: height)
        scroll.isPagingEnabled = true
    
        return scroll
    }()
    
    lazy var centerView: CameraView = {
        let cameraView = CameraView.init(frame: CGRect.init(x: screenWidth, y: 0, width: screenWidth, height: screenHeight))
        return cameraView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollViewSetting()
    }
    
    func scrollViewSetting(){
        view.addSubview(scrollView)
        
        let leftImageView = UIImageView.init(image: UIImage.init(named: "left"))
        leftImageView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        leftImageView.contentMode = UIView.ContentMode.scaleAspectFill
                
        let rightImageView = UIImageView(image: UIImage(named: "right"))
        rightImageView.frame = CGRect.init(x: screenWidth * 2, y: 0, width: screenWidth, height: screenHeight)
        rightImageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        scrollView.addSubview(leftImageView)
        scrollView.addSubview(centerView)
        scrollView.addSubview(rightImageView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        self.scrollView.addGestureRecognizer(tap)
    }
    
    @objc func tapClick(){
        print("dddd")
        centerView.didPressTakeAnother()
    }
}

