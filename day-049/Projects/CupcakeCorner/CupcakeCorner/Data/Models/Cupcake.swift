//
//  Cupcake.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/12/19.
// ✌️
//

import Foundation


struct Cupcake {
    var flavor: Flavor = .vanilla
}

extension Cupcake {
    enum Flavor: String, CaseIterable {
        case vanilla
        case strawberry
        case chocolate
        case rainbow
    }
}

extension Cupcake.Flavor: Hashable {}

extension Cupcake.Flavor: Identifiable {
    var id: String { rawValue }
}


extension Cupcake.Flavor {
    
    var formDisplayText: String {
        switch self {
        case .vanilla:
            return "🍨 Vanilla"
        case .strawberry:
            return "🍓 Strawberry"
        case .chocolate:
            return "🍫 Chocolate"
        case .rainbow:
            return "🌈 Rainbow"
        }
    }
    
    
    var cost: Double {
        switch self {
        case .vanilla:
            return 2_000
        case .strawberry:
            return 2_200
        case .chocolate:
            return 2_200
        case .rainbow:
            return 3_000
        }
    }
}

