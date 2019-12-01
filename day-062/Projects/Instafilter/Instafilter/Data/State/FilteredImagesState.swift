//
//  FilteredImagesState.swift
//  Instafilter
//
//  Created by CypherPoet on 11/29/19.
// ✌️
//

import Foundation
import UIKit
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils


struct FilteredImagesState {
    var currentInputImage: UIImage?
    var filteredOutputCGImage: CGImage?
    var filteringErrorMessage: String?
}


enum FilteredImagesSideEffect: SideEffect {
    case apply(filter: CIFilter, to: UIImage)
    
    func mapToAction() -> AnyPublisher<AppAction, Never> {
        switch self {
        case let .apply(filter, inputImage):
            return ImageFilteringService.shared
                .apply(filter, to: inputImage)
                .map { cgImage in
                    AppAction.filteredImages(.setFilteredOutput(image: cgImage))
                }
                .catch { (error: ImageFilteringService.Error) in
                    // TODO: Better handling here 🙈
                    Just(AppAction.filteredImages(.setFilteringError(message: "Failed")))
                }
                .eraseToAnyPublisher()
        }
    }
}


enum FilteredImagesAction {
    case setCurrentInput(image: UIImage)
    case setFilteredOutput(image: CGImage)
    case setFilteringError(message: String)
}



// MARK: - Reducer
let filteredImagesReducer = Reducer<FilteredImagesState, FilteredImagesAction> { state, action in
    switch action {
    case .setCurrentInput(let image):
        state.currentInputImage = image
    case .setFilteredOutput(let image):
        state.filteredOutputCGImage = image
    case .setFilteringError(let message):
        state.filteringErrorMessage = message
    }
}
