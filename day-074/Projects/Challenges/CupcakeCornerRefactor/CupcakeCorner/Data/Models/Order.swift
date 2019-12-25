//
//  Order.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/12/19.
// ✌️
//

import Foundation


struct Order {
    var cupcake: Cupcake?
    var quantity: Int
    var preferences: Preferences = .default
    var deliveryAddress: Address?
}

extension Order: Codable {}



// MARK: - Preferences
extension Order {
    struct Preferences {
        var hasSpecialRequest: Bool
        var wantsExtraFrosting: Bool
        var addsSprinkles: Bool
        
        
        static var `default` = Preferences(
            hasSpecialRequest: false,
            wantsExtraFrosting: false,
            addsSprinkles: false
        )
    }
}

extension Order.Preferences: Codable {}


// MARK: - Computeds
extension Order {
    
    private var baseCost: Double {
        Double(quantity) * (cupcake?.flavor.cost ?? 0.0)
    }
    
    private var customizationCost: Double {
        Double(quantity) *
        (
            (preferences.wantsExtraFrosting ? 500 : 0) +
            (preferences.addsSprinkles ? 500 : 0)
        )
    }
    
    
    var cost: Double {
        baseCost + customizationCost
    }
}
