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
    case astronaut(_ astronautAction: AstronautAction)
    case mission(_ missionAction: MissionAction)
}



struct AppState {
    var astronautsState = AstronautsState()
    var missionsState = MissionsState()
}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .mission(action):
        missionReducer.reduce(&appState.missionsState, action)
    case let .astronaut(action):
        astronautReducer.reduce(&appState.astronautsState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>

