//
//  CameraView.swift
//  Swift04
//
//  Created by 胡生才 on 2019/6/19.
//  Copyright © 2019 胡生才. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView: UIView,AVCapturePhotoCaptureDelegate{
    
    lazy var tempImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    

    lazy var captureSession: AVCaptureSession? = {
        let newCaptureSession = AVCaptureSession()
        newCaptureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        return newCaptureSession
    }()
    var photoOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tempImageView)
        addPhotoView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addPhotoView(){
        previewLayer?.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
        
        let backCamera = AVCaptureDevice.default(for: .video)
        
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        do{
            input = try AVCaptureDeviceInput.init(device: backCamera!)
        }
        catch let errorOthers as NSError{
            error = errorOthers
            input = nil
        }
        
        if (error == nil) {
            captureSession?.addInput(input)
            
            photoOutput = AVCaptureStillImageOutput()
            photoOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if let photoOutputTmep = photoOutput{
                if captureSession?.canAddOutput(photoOutputTmep) != nil{
                    captureSession?.addOutput(photoOutputTmep)
                    
                    if let captureSessionTemp = captureSession{
                        previewLayer = AVCaptureVideoPreviewLayer(session: captureSessionTemp)
                        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                        previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                        
                        layer.addSublayer(previewLayer!)
                        captureSession?.startRunning()
                    }
                }
            }
        }
    }
    
    func didPressTakePhoto() {
        
        if let videoConnection = photoOutput?.connection(with: .video) {
            videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
            photoOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) in
                if sampleBuffer != nil{
                    
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer!)
                    let dataProvider = CGDataProvider.init(data: imageData! as CFData)
                    let cgImageRef = CGImage.init(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent)
                    
                    let image = UIImage.init(cgImage: cgImageRef!, scale: 1.0, orientation: UIImage.Orientation.right)
                    
                    self.tempImageView.image = image
                    self.tempImageView.isHidden = false
                }
            })
        }
    }
    
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother() {
        if didTakePhoto == true {
            tempImageView.isHidden = true
            didTakePhoto = false
        }
        else{
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
        }
    }
    
}
