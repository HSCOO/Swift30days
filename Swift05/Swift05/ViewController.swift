//
//  ViewController.swift
//  Swift05
//
//  Created by 胡生才 on 2019/6/20.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate struct Storyboard{
        static let CellId = "InterestCollectionViewCell"
        static let CellPadding: CGFloat = 20.0
        static let CellItemHeight: CGFloat = 450.0
        static let ScreenWidth: CGFloat = UIScreen.main.bounds.width
    }
    
    fileprivate var interests = Interest.createInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellId, for: indexPath) as! InterestCollectionViewCell
        cell.interest = interests[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 2 * Storyboard.CellPadding, height: Storyboard.CellItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2 * Storyboard.CellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: Storyboard.CellPadding, bottom: 0, right: Storyboard.CellPadding)
    }
}

extension ViewController: UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // 处理pageenable效果，超过半页就自动偏移到下一页，不足半页就回到上一页
        let originPoint = targetContentOffset.pointee
        var index = Int(originPoint.x / Storyboard.ScreenWidth)
        let offset = Int(originPoint.x) % Int(Storyboard.ScreenWidth)
        
        index += (offset > Int(Storyboard.ScreenWidth / 2)) ? 1 : 0
        
        targetContentOffset.pointee = CGPoint(x: index * Int(Storyboard.ScreenWidth), y: 0)
    }
}

