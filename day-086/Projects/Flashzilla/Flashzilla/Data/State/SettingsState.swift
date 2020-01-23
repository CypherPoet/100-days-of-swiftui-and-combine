//
//  SettingsState.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/22/20.
// ✌️
//


import CypherPoetSwiftUIKit_DataFlowUtils
import UserDefault
import Combine


struct SettingsState {
    @UserDefault("settings-state-restacks-incorrect-cards", defaultValue: false)
    var restacksIncorrectCards: Bool
}


enum SettingsAction {
    case restacksIncorrectCardsSet(Bool)
}



// MARK: - Reducer
let settingsReducer: Reducer<SettingsState, SettingsAction> = Reducer(
    reduce: { state, action in
        switch action {
        case .restacksIncorrectCardsSet(let value):
            state.restacksIncorrectCards = value
        }
    }
)
