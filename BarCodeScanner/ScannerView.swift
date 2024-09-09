//
//  ScannerView.swift
//  BarCodeScanner
//
//  Created by Zakee Tanksley on 9/9/24.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    final class Coordinator: NSObject, ScannerViewControllerDelegate{
        func didFind(barcode: String) {
            print(barcode)
        }
        
        func didSurface(error: ScannerError) {
            print(error.self)
        }
    }
}



#Preview {
    ScannerView()
}
