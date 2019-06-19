//
//  ViewController.swift
//  Swift03
//
//  Created by 胡生才 on 2019/6/14.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UITableViewController {

   // 数据懒加载
   lazy var videos:[Video] = {
        return [
            Video(screenShot: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
            Video(screenShot: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
            Video(screenShot: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
            Video(screenShot: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
            Video(screenShot: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
            Video(screenShot: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
        ]
   }()
    
    lazy var playViewController:AVPlayerViewController = {
        return AVPlayerViewController()
    }()
    
    lazy var player: AVPlayer = {
        return AVPlayer()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        let video = videos[indexPath.row]

        cell.videoScreenShot.image = UIImage.init(named: video.screenShot)
        cell.videoTitleLabel.text = video.title
        cell.videoSourceLabel.text = video.source

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let mapFile = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        // 播放器
        player = AVPlayer.init(url: URL(fileURLWithPath: mapFile!))
        playViewController.player = player
        // 播放
        present(playViewController, animated: true) {
            self.playViewController.player?.play()
        }
    }
}


