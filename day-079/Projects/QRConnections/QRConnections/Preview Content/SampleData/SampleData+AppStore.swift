//
//  SampleData+AppStore.swift
//  QRConnections
//
//  Created by CypherPoet on 1/11/20.
// ✌️
//

import Foundation


extension SampleData {
    
    static let userProfileState = UserProfileState()
    
    
    static let appStore = AppStore(
        initialState: AppState(
            userProfileState: SampleData.userProfileState
        ),
        appReducer: appReducer
    )
}
