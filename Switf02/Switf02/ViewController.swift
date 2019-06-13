//
//  ViewController.swift
//  Switf02
//
//  Created by 胡生才 on 2019/6/13.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titles: Array<String>{
        get {
            return [
                    "30 Days Swift",
                    "这些字体特别适合打「奋斗」和「理想」",
                    "谢谢「造字工房」，本案例不涉及商业使用",
                    "使用到造字工房劲黑体，致黑体，童心体",
                    "呵呵，再见🤗 See you next Project",
                    "dskdks",
                    "测试测试测试测试测试测试",
                    "123",
                    "Alex",
                    "@@@@@@"
                  ]
        }
    }
    
    var fontNames: Array<String>{
        get {
            return [
                "MFTongXin_Noncommercial-Regular",
                "MFJinHei_Noncommercial-Regular",
                "MFZhiHei_Noncommercial-Regular",
                "Zapfino",
                "Gaspar Regular"
                    ]
        }
    }
    
    var selectedFontName: String = "Zapfino"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    

    @IBAction func changeBtnClick(_ sender: Any) {
        let fontNamesCount = fontNames.count
        let range = (0..<fontNamesCount)
        let arcIndex = Int.random(in: range)
        selectedFontName = fontNames[arcIndex]
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = titles[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell") as! TitleCell
        
        cell.titleLabel.text = title
        cell.titleLabel.font = UIFont.init(name: selectedFontName, size: 20)
        
        return cell
    }
}

