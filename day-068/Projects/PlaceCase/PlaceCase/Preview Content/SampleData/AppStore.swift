//
//  AppStore.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/9/19.
// ✌️
//

import Foundation
import CypherPoetSwiftUIKit_DataFlowUtils


#if DEBUG

extension SampleData {
    
    enum SampleAppStore {
        static let `default` = AppStore(initialState: AppState(), appReducer: appReducer)
    }
}

#endif
