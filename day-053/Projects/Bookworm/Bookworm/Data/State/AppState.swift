//
//  AppState.swift
//  Bookworm
//
//  Created by CypherPoet on 11/9/19.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct AppState {
    var coreDataState = CoreDataState()
}


enum AppAction {
    case coreData(_ coreDataAction: CoreDataAction)
}


//enum AppSideEffect: SideEffect {}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .coreData(action):
        coreDataReducer.reduce(&appState.coreDataState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
