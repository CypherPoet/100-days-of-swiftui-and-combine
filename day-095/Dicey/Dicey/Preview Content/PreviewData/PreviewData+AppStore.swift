//
//  PreviewData+AppStore.swift
//  Dicey
//
//  Created by CypherPoet on 2/2/20.
// ✌️
//

import Foundation


extension PreviewData {
    
    enum AppStores {
    
        static let `default`: AppStore = {
            AppStore(initialState: .init(), appReducer: appReducer)
        }()
    }
}
