//
//  PreviewData+AppStore.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/22/20.
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
