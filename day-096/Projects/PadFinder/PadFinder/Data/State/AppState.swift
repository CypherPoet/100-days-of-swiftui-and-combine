//
//  AppState.swift
//  PadFinder
//
//  Created by CypherPoet on 1/26/20.
// ✌️
//

import Foundation
import CypherPoetSwiftUIKit_DataFlowUtils



struct AppState {
    var padsState = PadsState()
}



//enum AppSideEffect: SideEffect {}

enum AppAction {
    case pads(_ action: PadsAction)
}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case .pads(let action):
        padsReducer.reduce(&appState.padsState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
