//
//  BarCodeScannerView.swift
//  BarCodeScannerApp
//
//  Created by Muhammad Zeshan on 11/07/2024.
//

import SwiftUI

struct BarCodeScannerView: View {
    
    @State private var scannedCode = ""
    
    var body: some View {
        
        NavigationStack{
            VStack{
                
                CoordinatorVC(scannedCode: $scannedCode)
                    .frame(maxWidth:.infinity,maxHeight:300)
               
                Label("Scanned Barcode:",systemImage:"barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not Yet Scanned": scannedCode)
                    .bold()
                    .foregroundStyle(scannedCode.isEmpty ? .red : .green)
                    .font(.largeTitle)
                
            }.navigationTitle("Barcode Scanner")
           
        }
    }
}

#Preview {
    BarCodeScannerView()
}
