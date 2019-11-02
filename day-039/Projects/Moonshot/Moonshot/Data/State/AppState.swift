//
//  AppState.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetCore_FileSystem
import CypherPoetSwiftUIKit_DataFlowUtils



enum AppAction {
    case mission(_ missionAction: MissionAction)
}



struct AppState {
    var missionState = MissionState()
}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .mission(action):
        missionReducer.reduce(&appState.missionState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>

