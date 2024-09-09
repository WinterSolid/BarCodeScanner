//
//  ScannerViewController.swift
//  BarCodeScanner
//
//  Created by Zakee Tanksley on 9/5/24.
// UIViewController -> Coordinator -> SwiftUI View

import UIKit
import AVFoundation

protocol ScannerViewControllerDelegate: AnyObject {
    func didFind(barcode: String)
    func didSurface(error: ScannerError)
}

final class ScannerViewController: UIViewController {
    // Capture whats on camera
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerViewControllerDelegate!
    
    init(scannerDelegate: ScannerViewControllerDelegate){
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return print("Error: No camera detected.")
        }
        previewLayer.frame = view.layer.bounds
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
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Error if no metadata objects are detected
        guard let object = metadataObjects.first else {
            handleError(BarcodeScanningError.noMetadataObject)
            return
        }
        
        // Error if the detected object is not machine-readable
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            handleError(BarcodeScanningError.nonMachineReadableObject)
            return
        }
        
        // Error if no barcode value is found
        guard let barcode = machineReadableObject.stringValue else {
            handleError(BarcodeScanningError.noBarcodeValue)
            return
        }
        
        // Notify the delegate with the detected barcode
        scannerDelegate?.didFind(barcode: barcode)
    }
}
// MARK: ERROR HANDLING
// Error enum for barcode scanning
enum BarcodeScanningError: Error {
    case noMetadataObject
    case nonMachineReadableObject
    case noBarcodeValue
}
// Helper function to handle errors
private func handleError(_ error: BarcodeScanningError) {
    switch error {
    case .noMetadataObject:
        print("Error: No metadata object detected.")
    case .nonMachineReadableObject:
        print("Error: Detected object is not a machine-readable code.")
    case .noBarcodeValue:
        print("Error: No barcode value found.")
    }
}

enum ScannerError: Error {
    case invalidDeviceInput
}
