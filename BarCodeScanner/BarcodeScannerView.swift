//
//  BarcodeScannerView.swift
//  BarCodeScanner
//
//  Created by Zakee Tanksley on 9/4/24.
//

import SwiftUI

struct BarcodeScannerView: View {
    var body: some View {
        NavigationView{
                VStack{
                    
                    Spacer()
                    
                    ScannerView()
                        .frame(maxWidth: .infinity,maxHeight: 500)
                        .border(Color.gray)
                    
                    Text("Will Appear Here").font(.title).foregroundColor(Color.red).padding(20)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "barcode.viewfinder")
                        Text("Scan Barcode")
                    }
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    
                    Spacer()
                }
            .navigationTitle("Barcode Scanner")
        }
    }
}
struct scanButton: View {
    var body: some View {
        HStack {
            Image(systemName: "barcode.viewfinder")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Scan Barcode")
        }
    }
}




#Preview {
    BarcodeScannerView()
}
