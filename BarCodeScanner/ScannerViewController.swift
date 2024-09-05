//
//  ScannerViewController.swift
//  BarCodeScanner
//
//  Created by Zakee Tanksley on 9/5/24.
// UIViewController -> Coordinator -> SwiftUI View

import UIKit
import AVFoundation

//
protocol ScannerViewControllerDelegate: AnyObject {
    func didFind(barcode: String)
}

final class ScannerViewController: UIViewController {
    // Capture whats on camera
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelagate: ScannerViewControllerDelegate!
    
    init(scannerDelagate: ScannerViewControllerDelegate){
        super.init(nibName: nil, bundle: nil)
        self.scannerDelagate = scannerDelagate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Failed to get the default video capture device.")
            return
        }
        
        var videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Failed to create video input: \(error.localizedDescription)")
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Could not add video input to the session.")
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        } else {
            print("Could not add metadata output to the session.")
            return
        }
    }
    
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
}
