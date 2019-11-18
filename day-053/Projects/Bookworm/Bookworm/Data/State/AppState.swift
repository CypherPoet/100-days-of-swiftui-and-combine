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
    var booksState = BooksState()
}


enum AppAction {
    case books(_ booksAction: BooksAction)
}


//enum AppSideEffect: SideEffect {}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .books(action):
        booksReducer.reduce(&appState.booksState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
