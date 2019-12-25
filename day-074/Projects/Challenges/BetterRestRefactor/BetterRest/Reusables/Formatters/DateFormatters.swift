//
//  DateFormatters.swift
//  BetterRest
//
//  Created by CypherPoet on 10/20/19.
// ✌️
//

import Foundation

enum DateFormatters {
    static let coffeeCutoffTime: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        return formatter
    }()
}
