//
//  NumberFormatters.swift
//  CupcakeCorner
//
//  Created by CypherPoet on 11/13/19.
// ✌️
//

import Foundation


enum NumberFormatters {
    static let orderCost: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        
        return formatter
    }()
}
