    //
//  AppState.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/22/20.
// ✌️
//


import Foundation
import CypherPoetSwiftUIKit_DataFlowUtils


struct AppState {
    var settingsState = SettingsState()
}



//enum AppSideEffect: SideEffect {}


enum AppAction {
    case settings(_ action: SettingsAction)
}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case .settings(let action):
        settingsReducer.reduce(&appState.settingsState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
