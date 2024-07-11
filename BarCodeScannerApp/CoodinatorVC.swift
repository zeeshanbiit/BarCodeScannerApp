//
//  CoodinatorVC.swift
//  BarCodeScannerApp
//
//  Created by Muhammad Zeshan on 12/07/2024.
//

import SwiftUI

struct CoordinatorVC: UIViewControllerRepresentable {
    
    @Binding var scannedCode:String
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) {
        // Implement updates if needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, ScannerDelegateVC {
        
        private var scannerView:CoordinatorVC
        
        init(scannerView:CoordinatorVC) {
            self.scannerView = scannerView
        }
        func didFind(barCode: String) {
            scannerView.scannedCode =  barCode
        }
        
        func didCheckSurface(error: CameraError) {
            print(error.rawValue)
        }
    }
    
    typealias UIViewControllerType = ScannerVC
}

#Preview {
    CoordinatorVC(scannedCode: .constant("123456"))
}
