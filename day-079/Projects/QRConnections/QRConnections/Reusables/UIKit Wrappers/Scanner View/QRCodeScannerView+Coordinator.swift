//
//  QRCodeScannerView+Coordinator.swift
//  QRConnections
//
//  Created by CypherPoet on 1/13/20.
// ✌️
//

import Foundation
import UIKit
import AVFoundation


// MARK: - Coordinator
extension QRCodeScannerView {

    class Coordinator: NSObject {
        let onScanCompleted: QRCodeScannerView.CompletionHandler
        let simulatedData: String
        
        init(
            simulatedData: String,
            onScanCompleted: @escaping QRCodeScannerView.CompletionHandler
        ) {
            self.simulatedData = simulatedData
            self.onScanCompleted = onScanCompleted
        }
    }
}


// MARK: - ScannerViewControllerCaptureSessionDelegate
extension QRCodeScannerView.Coordinator: ScannerViewControllerCaptureSessionDelegate {

    func captureSession(didScan metadataObject: ScannerViewController.CapturedOutput) {
        #if targetEnvironment(simulator)
        onScanCompleted(.success(simulatedData))
        
        #else
        
        guard
            let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
            let stringValue = readableObject.stringValue else
        { return }
        
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))

        onScanCompleted(.success(stringValue))
        
        #endif
    }
    
    func captureSessionWasUnableToAddInput() {
        onScanCompleted(.failure(.badInput))
    }
    
    func captureSessionWasUnableToAddOutput() {
        onScanCompleted(.failure(.badOutput))
    }
}
