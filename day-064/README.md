# Day 64: _Project 13: Instafilter_ (Part Three)

_Follow along at https://www.hackingwithswift.com/100/swiftui/64_.

<br/>


# 📒 Field Notes

This day covers Part Three of _`Project 13: Instafilter`_ in the [100 Days of SwiftUI Challenge](https://www.hackingwithswift.com/100/swiftui/64). (Project 13 files can be found in the [directory for Part One](../day-062/).)


It focuses on several specific topics:

- Using coordinators to manage SwiftUI view controllers
- How to save images to the user’s photo library


## How to save images to the user’s photo library

We could use the super-archaic [`UIImageWriteToSavedPhotosAlbum` method](https://developer.apple.com/documentation/uikit/1619125-uiimagewritetosavedphotosalbum) -- or we can take advantage of `PhotoKit`'s `PHPhotoLibrary` class, which offers a number of utilities for creating and saving images assets that don't rely on passing `UnsafeRawPointer`s around 😆.

Even better, we can wrap our `PHPhotoLibrary` calls in Combine `Future`s that can be resolved in other @ObservableObjects -- creating reactive streams that update according to how an operation turned out.

```swift

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

```


<br/>
