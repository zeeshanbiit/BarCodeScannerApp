//
//  BarCodeScannerViewDelegate.swift
//  BarCodeScannerApp
//
//  Created by Muhammad Zeshan on 12/07/2024.
//

import Foundation
import AVFoundation
import UIKit

enum CameraError:String{
    case invalidDeviceInput = "Something is wrong with the camera.  We are unable to capture the input."
    case invalidScannedValue = "The value scanned is not valid. This app scans EAN-8 and EAN-13."
}
protocol ScannerDelegateVC : class{
    
    func didFind(barCode:String)
    func didCheckSurface(error: CameraError)
}


final class ScannerVC : UIViewController{
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerDelegateVC?
    
    init(scannerDelegate: ScannerDelegateVC){
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else{
            scannerDelegate?.didCheckSurface(error: .invalidDeviceInput)
            return
        }
        previewLayer.frame = view.layer.bounds
    }
    
    
    private func setupCaptureSession(){
        
        guard let videoCapture = AVCaptureDevice.default(for: .video) else{
            scannerDelegate?.didCheckSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput:AVCaptureDeviceInput
        do{
            try videoInput = AVCaptureDeviceInput(device: videoCapture)
            
        } catch{
            scannerDelegate?.didCheckSurface(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }else{
            scannerDelegate?.didCheckSurface(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput){
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8 , .ean13]
        }else{
            scannerDelegate?.didCheckSurface(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
        
           
    }
}

extension ScannerVC:AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        guard let object = metadataObjects.first else{
            scannerDelegate?.didCheckSurface(error: .invalidScannedValue)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else{
            scannerDelegate?.didCheckSurface(error: .invalidScannedValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else{
            scannerDelegate?.didCheckSurface(error: .invalidScannedValue)
            return
        }
        
        scannerDelegate?.didFind(barCode: barcode)
    }
}
