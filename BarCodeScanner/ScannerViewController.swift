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
            // Array of Barcode Types to scan:  = 8 digit,13 digit -Barcodes
            metaDataOutput.metadataObjectTypes = [.ean8,.ean13]
        } else {
            print("Could not add metadata output to the session.")
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        guard let previewLayer = previewLayer else {
            print("previewLayer is nil")
            return
        }
        // Indicates how the layer displays video content within its bounds.
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()

    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    // Delegate method called when a new metadata object is detected
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if there's at least one detected metadata object
        guard let object = metadataObjects.first else {
            return
        }
        
        // Attempt to cast the first metadata object to a machine-readable code object
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        // Get the barcode's string value if available
        guard let barcode = machineReadableObject.stringValue else {
            return
        }
        
        // Notify the delegate with the detected barcode
        scannerDelagate?.didFind(barcode: barcode)
    }
}

