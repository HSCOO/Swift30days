//
//  InterestCollectionViewCell.swift
//  Swift05
//
//  Created by 胡生才 on 2019/6/21.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var featuredImageView: UIImageView!
    
    var interest: Interest!{
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI(){
        interestTitleLabel.text = interest.title
        featuredImageView.image = interest.feturedImage
    }
}
