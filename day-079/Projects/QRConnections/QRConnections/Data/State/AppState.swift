//
//  AppState.swift
//  QRConnections
//
//  Created by CypherPoet on 1/11/20.
// ✌️
//


import Foundation
import CypherPoetSwiftUIKit_DataFlowUtils


struct AppState {
    var userProfileState = UserProfileState()
}



//enum AppSideEffect: SideEffect {}



enum AppAction {
    case userProfile(_ action: UserProfileAction)
}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case .userProfile(let action):
        userProfileReducer.reduce(&appState.userProfileState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
