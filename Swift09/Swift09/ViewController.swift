//
//  ViewController.swift
//  Swift09
//
//  Created by 胡生才 on 2019/7/1.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }


}


extension ViewController: UIScrollViewDelegate {
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize){
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        // 为了让图片完整显示，取宽高的最小缩放比例
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    // 缩放时动态改变布局
    fileprivate func updateConstraintsForSize(_ size: CGSize){
        // 目的是动态改变约束使图片居中
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset;
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeftConstraint.constant = xOffset
        imageViewRightConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}



