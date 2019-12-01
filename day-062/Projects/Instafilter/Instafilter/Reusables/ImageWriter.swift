//
//  ImageWriter.swift
//  Instafilter
//
//  Created by CypherPoet on 11/29/19.
// ✌️
//

import Foundation
import UIKit
import Combine
import Photos


enum ImageWriter {
    static let defaultQueue = DispatchQueue(label: "Image Writer", qos: .userInitiated)
    
    enum Error: Swift.Error, Identifiable {
        var id: String { self.localizedDescription }
        
        case failedToCreateAsset
        case genericWritingError(Swift.Error)
    }
    
    
    static func write(
        imageToPhotoAlbum image: UIImage,
        on queue: DispatchQueue = defaultQueue
    ) -> Future<String, ImageWriter.Error> {
        Future { resolve in
            queue.async {
                do {
                    try PHPhotoLibrary.shared().performChangesAndWait {
                        let creationRequest = PHAssetCreationRequest.creationRequestForAsset(from: image)

                        guard let savedAssetID = creationRequest.placeholderForCreatedAsset?.localIdentifier else {
                            return resolve(.failure(.failedToCreateAsset))
                        }
                        
                        resolve(.success(savedAssetID))
                    }
                } catch {
                    resolve(.failure(.genericWritingError(error)))
                }
            }
        }
    }
}


extension ImageWriter {
    
    static var isAuthorized: Future<Bool, Never> {
        Future { resolve in
            PHPhotoLibrary.requestAuthorization({ authStatus in
                switch authStatus {
                case .authorized:
                    resolve(.success(true))
                case .notDetermined,
                     .restricted,
                     .denied:
                    resolve(.success(false))
                 @unknown default:
                    resolve(.success(false))
                }
            })
        }
    }
    
    
}



// TODO: This might not be needed... sort of just experimenting here 🙂
extension PHPhotoLibrary {
    
    static func fetchAuthStatus(then completionHandler: @escaping (Bool) -> Void) {
        
        // If authozied, callback immediately.
        guard authorizationStatus() != .authorized else {
            return completionHandler(true)
        }

        requestAuthorization { (status) in
            completionHandler(status == .authorized)
        }
    }
}
