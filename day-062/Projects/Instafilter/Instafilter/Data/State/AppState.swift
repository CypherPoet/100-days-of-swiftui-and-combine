//
//  AppState.swift
//  Instafilter
//
//  Created by CypherPoet on 11/27/19.
// ✌️
//

import Foundation
import CypherPoetSwiftUIKit_DataFlowUtils


struct AppState {
    var filteredImages = FilteredImagesState()
    var imageWriting = ImageWritingState()
}


enum AppAction {
    case filteredImages(_ filteredImagesAction: FilteredImagesAction)
    case imageWriting(_ imageWritingAction: ImageWritingAction)
}


//enum AppSideEffect: SideEffect {}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .filteredImages(action):
        filteredImagesReducer.reduce(&appState.filteredImages, action)
    case let .imageWriting(action):
        imageWritingReducer.reduce(&appState.imageWriting, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
