//
//  NumberFormatters.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/24/19.
// ✌️
//

import Foundation


enum NumberFormatters {
    static var apsisLength: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        
        return formatter
    }()
}
