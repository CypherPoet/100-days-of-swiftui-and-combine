import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import Combine
import UIKit



public final class ImageFilterService {
    public typealias FilterAtrributes = [String: Any]
 
    public enum Error: Swift.Error {
        case cgImage(_ message: String)
        case ciImage(_ message: String)
        case filtering(_ message: String)
    }
    
    // 🔑 Creating a CIContext is expensive, so we'll create it once and reuse it throughout the app.
    lazy private var context = CIContext()
    
    
    public let filteringQueue: DispatchQueue
    
    
    public init(
        queue filteringQueue: DispatchQueue = DispatchQueue(
            label: "Image Filtering Service",
            qos: .userInitiated
        )
    ) {
        self.filteringQueue = filteringQueue
    }
}


extension ImageFilterService {
    
    public func createCGImage(
        from filter: CIFilter,
        withAttributes filterAtrributes: FilterAtrributes = [:]
    ) -> AnyPublisher<CGImage, ImageFilterService.Error> {
        createCIImage(byApplying: filter, withAttributes: filterAtrributes)
            .flatMap(createCGImage(from:))
            .eraseToAnyPublisher()
    }
    
    
    private func createCGImage(
        from filteredImage: CIImage
    ) -> AnyPublisher<CGImage, ImageFilterService.Error> {
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
            .mapError( { $0 as! ImageFilterService.Error })
            .eraseToAnyPublisher()
    }
    
    
    private func createCIImage(
        byApplying filter: CIFilter,
        withAttributes filterAtrributes: FilterAtrributes = [:]
    ) -> AnyPublisher<CIImage, ImageFilterService.Error> {
        Just(filter)
            .tryMap { filter in
                for (key, value) in filterAtrributes {
                    filter.setValue(value, forKey: key)
                }
                
                guard let filteredImage = filter.outputImage else {
                    throw Error.filtering("Failed to output image during filtering")
                }

                return filteredImage
            }
            .mapError( { $0 as! ImageFilterService.Error })
            .eraseToAnyPublisher()
    }
}


extension ImageFilterService {
    public static let shared = ImageFilterService()
}
