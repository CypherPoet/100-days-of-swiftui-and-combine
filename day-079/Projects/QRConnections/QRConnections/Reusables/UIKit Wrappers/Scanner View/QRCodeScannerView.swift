//
//  QRCodeScannerView.swift
//  QRConnections
//
//  Created by CypherPoet on 1/13/20.
// ✌️
//


import SwiftUI
import AVFoundation


struct QRCodeScannerView {
    typealias UIViewControllerType = ScannerViewController
    typealias Completion = Result<String, ScanError>
    typealias CompletionHandler = ((Completion) -> Void)
    
    var codeTypes: [AVMetadataObject.ObjectType] = [.qr]
    var simulatedData = ""
    let onScanCompleted: CompletionHandler
}


extension QRCodeScannerView {
    enum ScanError: Error {
        case badInput
        case badOutput
    }
}

// MARK: - UIViewControllerRepresentable
extension QRCodeScannerView: UIViewControllerRepresentable {

    func makeCoordinator() -> Self.Coordinator {
        Self.Coordinator(
            simulatedData: simulatedData,
            onScanCompleted: onScanCompleted
        )
    }


    func makeUIViewController(
        context: UIViewControllerRepresentableContext<QRCodeScannerView>
    ) -> UIViewControllerType {
        let viewController = ScannerViewController()
        
        viewController.codeTypes = codeTypes
        viewController.captureSessionDelegate = context.coordinator
        
        return viewController
    }


    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: UIViewControllerRepresentableContext<QRCodeScannerView>
    ) {
    }
}



// MARK: - Preview
struct QRCodeScannerView_Previews: PreviewProvider {

    static var previews: some View {
        QRCodeScannerView(onScanCompleted: { _ in })
    }
}
