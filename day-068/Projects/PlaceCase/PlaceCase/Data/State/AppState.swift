//
//  AppState.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/9/19.
// ✌️
//


import SwiftUI
import CypherPoetSwiftUIKit
import UserDefault
import LocalAuthentication


struct AppState {
    var authenticationService: AuthenticationService
    var locationCollectionsState: LocationCollectionsState
    var wikiPagesState: WikiPagesState
    
    
    @UserDefault("isFirstRun", defaultValue: true)
    var isFirstRun: Bool
    
    
    init(
        authenticationService: AuthenticationService = AuthenticationService(laContextType: LAContext.self),
        locationCollectionsState: LocationCollectionsState = .init(),
        wikiPagesState: WikiPagesState = .init()
    ) {
        self.authenticationService = authenticationService
        self.locationCollectionsState = locationCollectionsState
        self.wikiPagesState = wikiPagesState
    }
}



enum AppAction {
    case setIsFirstRun(to: Bool)
    case locationCollections(_ locationCollectionsAction: LocationCollectionsAction)
    case wikiPages(_ wikiPagesAction: WikiPagesAction)
}


//enum AppSideEffect: SideEffect {}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .setIsFirstRun(isFirstRun):
        appState.isFirstRun = isFirstRun
    case let .locationCollections(action):
        locationCollectionsReducer.reduce(&appState.locationCollectionsState, action)
    case .wikiPages(let action):
        wikiPagesReducer.reduce(&appState.wikiPagesState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
