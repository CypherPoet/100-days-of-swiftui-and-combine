//
//  NumberFormatters.swift
//  BetterRest
//
//  Created by CypherPoet on 10/19/19.
// ✌️
//

import Foundation


enum NumberFormatters {
    static let sleepAmount: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.maximumSignificantDigits = 4
        formatter.maximumFractionDigits = 2
        
        return formatter
    }()
}
