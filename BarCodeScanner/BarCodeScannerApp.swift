//
//  BarCodeScannerApp.swift
//  BarCodeScanner
//
//  Created by Zakee Tanksley on 9/4/24.
//

import SwiftUI

@main
struct BarCodeScannerApp: App {
    @StateObject private var cameraPermissionManager = CameraPermissionManager()

    var body: some Scene {
        WindowGroup {
            BarcodeScannerView()
                .onAppear {
                    cameraPermissionManager.requestCameraPermission()
                }
        }
    }
}
