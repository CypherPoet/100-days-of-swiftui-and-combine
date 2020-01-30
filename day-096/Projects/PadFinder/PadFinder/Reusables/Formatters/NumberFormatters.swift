//
//  Double+CoordinateFormat.swift
//  PadFinder
//
//  Created by CypherPoet on 1/27/20.
// ✌️
//

import Foundation


enum NumberFormatters {
    
    static var padCoordinateDisplay: NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        
        return formatter
    }
}
