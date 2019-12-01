//
//  SampleData.swift
//  Instafilter
//
//  Created by CypherPoet on 11/29/19.
// ✌️
//

#if DEBUG

import Foundation


enum SampleStore {
    static let `default` = AppStore(initialState: AppState(), appReducer: appReducer)
}


#endif
