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
    var authenticationService: AuthenticatingService
    var locationCollectionsState: LocationCollectionsState
    
    @UserDefault("isFirstRun", defaultValue: true)
    var isFirstRun: Bool
    
    
    init(
        authenticationService: AuthenticatingService = AuthenticationService(laContextType: LAContext.self),
        locationCollectionsState: LocationCollectionsState = .init()
    ) {
        self.authenticationService = authenticationService
        self.locationCollectionsState = locationCollectionsState
    }
}



enum AppAction {
    case setIsFirstRun(to: Bool)
    case locationCollections(_ locationCollectionsAction: LocationCollectionsAction)
}


//enum AppSideEffect: SideEffect {}


// MARK: - Reducer
let appReducer = Reducer<AppState, AppAction> { appState, action in
    switch action {
    case let .setIsFirstRun(isFirstRun):
        appState.isFirstRun = isFirstRun
    case let .locationCollections(action):
        locationCollectionsReducer.reduce(&appState.locationCollectionsState, action)
    }
}


typealias AppStore = Store<AppState, AppAction>
