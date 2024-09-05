//
//  BarcodeView.swift
//  BarCodeScanner
//
//  Created by Zakee Tanksley on 9/4/24.
//

import SwiftUI

struct BarcodeView: View {
    @State private var isScanned = false
    @State private var barcode: String = ""
    
    var body: some View {
        VStack {
            if isScanned {
                Text(barcode)
                    .foregroundColor(.blue)
            } else {
                Text("Not yet Scanned")
                    .foregroundColor(.red)
            }
        }
    }
}
