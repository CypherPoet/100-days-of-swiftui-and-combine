//
//  ImageWritingState.swift
//  Instafilter
//
//  Created by CypherPoet on 11/30/19.
// ✌️
//


import Foundation
import UIKit
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils


struct ImageWritingState {
    var hasWritingError: Bool { writingError != nil }
    var writingError: ImageWriter.Error?
}



enum ImageWritingSideEffect: SideEffect {
    case saveOutput(image: CGImage)

    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case let .saveOutput(cgImage):
            let imageToSave = UIImage(cgImage: cgImage)
            
            return ImageWriter
                .write(imageToPhotoAlbum: imageToSave)
                .map { _ in AppAction.imageWriting(.setWritingSuccess) }
                .catch({ (imageWriterError) in
                    Just(AppAction.imageWriting(.setWritingError(imageWriterError)))
                })
                .eraseToAnyPublisher()
        }
    }
}


enum ImageWritingAction {
    case setWritingError(ImageWriter.Error)
    case setWritingSuccess
}



// MARK: - Reducer
let imageWritingReducer = Reducer<ImageWritingState, ImageWritingAction> { state, action in
    switch action {
    case let .setWritingError(error):
        state.writingError = error
    case .setWritingSuccess:
        state.writingError = nil
    }
}
