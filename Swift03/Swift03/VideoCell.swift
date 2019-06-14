//
//  VideoCell.swift
//  Swift03
//
//  Created by 胡生才 on 2019/6/14.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

struct Video{
    let screenShot: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
 
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var videoScreenShot: UIImageView!
    @IBOutlet weak var videoSourceLabel: UILabel!
}
