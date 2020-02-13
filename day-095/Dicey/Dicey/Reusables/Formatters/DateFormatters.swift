//
//  DateFormatters.swift
//  Dicey
//
//  Created by CypherPoet on 2/13/20.
// ✌️
//

import Foundation


enum DateFormatters {
    static let diceRollListItem: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return formatter
    }()
}
