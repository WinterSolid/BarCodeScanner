//
//  CameraPermissionMAnager.swift
//  BarCodeScanner
//
//  Created by Zakee Tanksley on 9/4/24.
//

import SwiftUI
import AVFoundation

class CameraPermissionManager: ObservableObject {
    func requestCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Permission already granted
            print("Camera access already authorized.")
        case .notDetermined:
            // Permission not determined, request access
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Camera access granted.")
                } else {
                    print("Camera access denied.")
                }
            }
        case .denied, .restricted:
            // Permission denied or restricted
            print("Camera access denied or restricted.")
        @unknown default:
            print("Unknown camera authorization status.")
        }
    }
}
