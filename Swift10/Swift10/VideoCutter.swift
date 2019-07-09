//
//  VideoCutter.swift
//  Swift10
//
//  Created by 胡生才 on 2019/7/4.
//  Copyright © 2019 胡生才. All rights reserved.
//

import Foundation
import AVFoundation

extension String{
    var convert: NSString {
        return (self as NSString)
    }
}

class VideoCutter: NSObject{
    
    func cropVideoWithUrl(video url: URL, startTime: CGFloat, duration: CGFloat, completion:((_ videoPath: URL?, _ error: NSError?) -> Void)?) {
        
        DispatchQueue.global(qos: .default).async {
            let asset = AVURLAsset(url: url, options: nil)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let path: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputURL = path.firstObject as! String
            let manager = FileManager.default
            // 异常处理：
            // try？：将错误转化为可选异常，有错误时就返回nil
            // try！：禁止错误传递，当确认无异常发生时，否则发生运行时错误
            // defer ：从后往前执行。延迟执行不能包含任何控制语句
            do {
                try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error{
                print(error)
            }
            outputURL = outputURL.convert.appendingPathComponent("output.mp4")
            
            do {
                try manager.removeItem(atPath: outputURL)
            }
            catch _{
            }
            
            if let exportSession = exportSession as AVAssetExportSession? {
                exportSession.outputURL = URL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileType.mp4
                let start = CMTimeMakeWithSeconds(Float64(startTime), preferredTimescale: 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: 600)
                let range = CMTimeRangeMake(start: start, duration: duration)
                exportSession.timeRange = range
                
                exportSession.exportAsynchronously(completionHandler: {
                    switch exportSession.status{
                        
                    case .completed:
                        completion?(exportSession.outputURL,nil)
                        
                    case .failed:
                        print("Failed: \(String(describing: exportSession.error))")
                        
                    case .cancelled:
                        print("Failed: \(String(describing: exportSession.error))")
                        
                    default:
                        print("default case")
                    }
                })
            }
            
        }
    }
}
