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
    var filteredOutputCGImage: CGImage?
}


//enum FilteredImagesSideEffect: SideEffect {}


enum FilteredImagesAction {
    case setFilteredOutput(image: CGImage)
}



// MARK: - Reducer
let filteredImagesReducer = Reducer<FilteredImagesState, FilteredImagesAction> { state, action in
    switch action {
    case .setFilteredOutput(let image):
        state.filteredOutputCGImage = image
    }
}
