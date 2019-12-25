//
//  AppState.swift
//
//  Created by CypherPoet on 11/9/19.
// ✌️
//

import SwiftUI
import CypherPoetSwiftUIKit


struct AppState {
    var ordersState = OrdersState()
}


enum AppAction {
    case orders(_ ordersAction: OrdersAction)
}


//enum AppSideEffect: SideEffect {}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .orders(action):
        ordersReducer.reduce(&appState.ordersState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
