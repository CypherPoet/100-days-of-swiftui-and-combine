//
//  SampleData.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//


#if DEBUG

import Foundation



enum SampleAppState {
    static let `default` = AppState()
}


enum SampleStore {
    static let `default` = AppStore(initialState: SampleAppState.default, appReducer: appReducer)
}



#endif
