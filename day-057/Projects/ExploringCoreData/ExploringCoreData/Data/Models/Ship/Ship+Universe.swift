//
//  Ship+Universe.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/21/19.
// ✌️
//

import Foundation


extension Ship {
    enum Universe: Int32 {
        case starWars
        case starTrek
    }
}

extension Ship.Universe: CaseIterable {}

extension Ship.Universe: Identifiable {
    var id: Int32 { rawValue }
}


// MARK: - Computeds
extension Ship.Universe {
    
    var displayName: String {
        switch self {
        case .starWars:
            return "Star Wars"
        case .starTrek:
            return "Star Trek"
        }
    }
}
