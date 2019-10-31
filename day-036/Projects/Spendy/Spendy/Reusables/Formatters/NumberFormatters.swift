//
//  NumberFormatters.swift
//  Spendy
//
//  Created by CypherPoet on 10/30/19.
// ✌️
//

import Foundation


enum NumberFormatters {
    static let satoshis: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.maximumIntegerDigits = 15
        
        return formatter
    }()
}
