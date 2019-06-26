//
//  ViewController.swift
//  Swift07
//
//  Created by 胡生才 on 2019/6/26.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var index = 0
    let cellId = "newcellid"
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    
    var emojiData = [String]()
    // 01 懒加载可以更好的封装控件的属性设置，不至于散落
    lazy var tableView:UITableView = {
        let newTableView = UITableView(frame: UIScreen.main.bounds, style: UITableView.Style.plain)
        newTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        newTableView.dataSource = self
        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = 30
        newTableView.tableFooterView = UIView()
        newTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        return newTableView
    }()
    
    lazy var refreshControl:UIRefreshControl = {
        let newRefreshControl = UIRefreshControl()
        newRefreshControl.backgroundColor = UIColor.init(red: 0.113, green: 0.113, blue: 0.145, alpha: 1)
        newRefreshControl.attributedTitle = NSAttributedString(string: "最后更新于 \(Date())", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        newRefreshControl.tintColor = UIColor.white
        newRefreshControl.addTarget(self, action: #selector(ViewController.fresh), for: UIControl.Event.valueChanged)
        
        return newRefreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.refreshControl = refreshControl
        // 初始化数据源
        emojiData = favoriteEmoji
    }
    
    @objc func fresh(){
        // 02 disafter的swift版本
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            // 模拟数据源切换
            self.emojiData = [self.newFavoriteEmoji,self.favoriteEmoji][self.index]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.index = (self.index + 1) % 2
        }
    }

}

// 03 代理统一用extension区分，划分逻辑模块
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil){
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = emojiData[indexPath.row]
        cell?.textLabel?.textAlignment = NSTextAlignment.center
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 50)
        cell?.backgroundColor = UIColor.clear
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell!
    }
}

