//
//  ImageFilteringService.swift
//  Instafilter
//
//  Created by CypherPoet on 11/27/19.
// ✌️
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import Combine
import UIKit


final class ImageFilteringService {
    public typealias FilterAtrributes = [String: Any]
 
    enum Error: Swift.Error {
        case cgImage(_ message: String)
        case ciImage(_ message: String)
        case filtering(_ message: String)
    }
    
    
    let filteringQueue: DispatchQueue
    
    // 🔑 Creating a CIContext is expensive, so we'll create it once and reuse it throughout the app.
    lazy var context = CIContext()
    
    
    init(
        queue filteringQueue: DispatchQueue = DispatchQueue(
            label: "Image Filtering Service",
            qos: .userInitiated
        )
    ) {
        self.filteringQueue = filteringQueue
    }
}


extension ImageFilteringService {
    
    func createCGImage(from filteredImage: CIImage) -> AnyPublisher<CGImage, ImageFilteringService.Error> {
        Just(filteredImage)
            .print("createCGImage")
            .tryMap { filteredImage -> CGImage in
                guard
                    let cgImage = self.context.createCGImage(filteredImage, from: filteredImage.extent)
                else {
                    print("createCGImage failed")
                    throw Error.cgImage("Failed to create cgImage from filtered ciImage")
                }
                
                return cgImage
            }
            .mapError( { $0 as! ImageFilteringService.Error })
            .eraseToAnyPublisher()
    }
    
    
    func createCIImage(
        from uiImage: UIImage,
        byApplying filter: CIFilter,
        withAttributes filterAtrributes: FilterAtrributes = [:]
    ) -> AnyPublisher<CIImage, ImageFilteringService.Error> {
        Just(uiImage)
            .print("createCIImage")
            .tryMap { uiImage -> CIImage in
                guard let startingImage = CIImage(image: uiImage) else {
                    throw Error.ciImage("Failed to create ciImage from uiImage before filtering")
                }
                
                return startingImage
            }
            .tryMap { startingImage -> CIImage in
                filter.setValue(startingImage, forKey: kCIInputImageKey)
                
                for (key, value) in filterAtrributes {
                    filter.setValue(value, forKey: key)
                }
                
                guard let filteredImage = filter.outputImage else {
                    throw Error.filtering("Failed to output image during filtering")
                }
                
                return filteredImage
            }
            .mapError( { $0 as! ImageFilteringService.Error })
            .eraseToAnyPublisher()
    }
    
    
    
    func apply(
        _ filter: CIFilter,
        to uiImage: UIImage,
        withAttributes filterAtrributes: FilterAtrributes = [:]
    ) -> AnyPublisher<CGImage, ImageFilteringService.Error> {
        createCIImage(from: uiImage, byApplying: filter, withAttributes: filterAtrributes)
            .subscribe(on: filteringQueue)
            .flatMap { ciImage in
                self.createCGImage(from: ciImage)
            }
//            .map(createCGImage(from:))
//            .switchToLatest()
//            .map({ $0 })
            .eraseToAnyPublisher()
    }
}


extension ImageFilteringService {
    public static let shared = ImageFilteringService()
}
