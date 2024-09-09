# Barcode Scanner App

The Barcode Scanner App is a lightweight, user-friendly application designed to scan and decode barcodes using your device's camera. This app supports two UPC barcode formats.

## Features

- Real-time Barcode Scanning: Quickly scan barcodes using your device's camera.
- Delegate-Based Error Handling: Provides clear error messages and user feedback if barcode scanning fails.
- SwiftUI Integration: Built using SwiftUI, ensuring smooth and modern UI/UX.
## <img width="354" alt="Screenshot 2024-09-09 at 12 26 01 PM" src="https://github.com/user-attachments/assets/064b0397-70c7-44e3-8629-a6825f92768c">

## <img width="328" alt="Screenshot 2024-09-09 at 12 25 37 PM" src="https://github.com/user-attachments/assets/82360fbb-0be4-43e6-8671-749d76eaadd4">

## Requirements

- iOS 13.0 or later
- Xcode 12.0 or later
- Swift 5.0
📦 Installation

## Clone the Repository:
- git clone https://github.com/WinterSolid/BarCodeScanner.git

## Code Overview

### ScannerViewController
The core view controller responsible for setting up the camera and managing barcode scanning.

### setupCaptureSession: Configures the camera session for barcode scanning.
### metadataOutput: Delegate method called when a barcode is detected.
### Error Handling: Uses ScannerDelegate for handling errors and results.
### ScannerDelegate: A protocol to handle barcode detection and errors.

### didFind(barcode: String): Called when a valid barcode is scanned.
### didSurface(error: ScannerError): Called when there is an error (e.g., invalid device input).

### Supported Barcode Formats: Modify the AVCaptureMetadataOutput to scan only specific barcode types by setting its metadataObjectTypes property.
