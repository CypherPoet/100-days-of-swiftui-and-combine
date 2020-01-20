//
//  NumberFormatters.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/20/20.
// ✌️
//

import Foundation


enum NumberFormatters {
    
    static let cardCountdown: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }()
}
