//
//  ScannerViewControlller.swift
//  QRConnections
//
//  Created by CypherPoet on 1/14/20.
// ✌️
//

import AVFoundation
import UIKit


protocol ScannerViewControllerCaptureSessionDelegate: class {
    func captureSession(didScan metadataObject: ScannerViewController.CapturedOutput)
    func captureSessionWasUnableToAddInput()
    func captureSessionWasUnableToAddOutput()
}


public final class ScannerViewController: UIViewController {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    var codeTypes: [AVMetadataObject.ObjectType] = [.qr]
    weak var captureSessionDelegate: ScannerViewControllerCaptureSessionDelegate?
}


extension ScannerViewController {
    #if targetEnvironment(simulator)
    typealias CapturedOutput = String
    #else
    typealias CapturedOutput = AVMetadataObject
    #endif
}



// MARK: - Computeds
extension ScannerViewController {

    override public var prefersStatusBarHidden: Bool {
        return true
    }

    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


// MARK: - View Controller Lifecycle

#if targetEnvironment(simulator)

extension ScannerViewController {
    
    override public func loadView() {
        view = UIView()
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "You're running in the simulator, which means the camera isn't available. Tap anywhere to send back some simulated data."
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        captureSessionDelegate?.captureSession(didScan: "")
        dismiss(animated: true)
    }
}
    

#else


extension ScannerViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }

        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            captureSessionDelegate?.captureSessionWasUnableToAddInput()
            return
        }

        
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = codeTypes
        } else {
            captureSessionDelegate?.captureSessionWasUnableToAddOutput()
            return
        }

        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }


    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
}

#endif


#if targetEnvironment(simulator)
#else
extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            captureSessionDelegate?.captureSession(didScan: metadataObject)
        }

        dismiss(animated: true)
    }
}
#endif
