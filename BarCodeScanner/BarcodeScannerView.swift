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
                
                //TODO: Rectagle camera placeholder
                Rectangle().frame(maxWidth: .infinity,maxHeight: 300).border(Color.black)
                
                Spacer()
                
                Button(action: {
                    // TODO: Action to perform when the button is tapped
                }) {
                    HStack {
                        Image(systemName: "barcode.viewfinder")
                        Text("Scan Barcode")
                    }
                    .font(.headline)
                    .padding(20)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                Text("Not Scanned").font(.title).foregroundColor(Color.red).padding()
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
