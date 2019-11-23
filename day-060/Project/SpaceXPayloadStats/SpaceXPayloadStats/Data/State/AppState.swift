//
//  AppState.swift
//
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct AppState: Codable {
    var missionsState = MissionsState()
    var payloadsState = PayloadsState()
}


enum AppAction {
    case missions(_ missionsAction: MissionsAction)
    case payloads(_ payloadsAction: PayloadsAction)
}


//enum AppSideEffect: SideEffect {}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .missions(action):
        missionsReducer.reduce(&appState.missionsState, action)
    case let .payloads(action):
        payloadsReducer.reduce(&appState.payloadsState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
