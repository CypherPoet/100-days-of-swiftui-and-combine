//
//  AppState.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//


import Foundation
import Combine
import CypherPoetSwiftUIKit_DataFlowUtils



struct AppState {
    var diceGeneratorState = DiceGeneratorState()
}



//enum AppSideEffect: SideEffect {
//
//}



enum AppAction {
    case diceGenerator(_ action: DiceGeneratorAction)
}


// MARK: - Reducer
let appReducer: Reducer<AppState, AppAction> = Reducer(
    reduce: { appState, action in
        switch action {
        case .diceGenerator(let action):
            diceGeneratorReducer.reduce(&appState.diceGeneratorState, action)
        }
    }
)


typealias AppStore = Store<AppState, AppAction>
