//
//  BarCodeScannerView.swift
//  BarCodeScannerApp
//
//  Created by Muhammad Zeshan on 11/07/2024.
//

import SwiftUI

struct BarCodeScannerView: View {
    var body: some View {
        
        NavigationStack{
            VStack{
                
                Rectangle()
                    .frame(maxWidth:.infinity,maxHeight:300)
               
                Label("Scanned Barcode:",systemImage:"barcode.viewfinder")
                    .font(.title)
                
                Text("Not Yet Scanned")
                    .bold()
                    .foregroundStyle(.red)
                    .font(.largeTitle)
                
            }.navigationTitle("Barcode Scanner")
           
        }
        
        
        
       
        
        
    }
}

#Preview {
    BarCodeScannerView()
}
