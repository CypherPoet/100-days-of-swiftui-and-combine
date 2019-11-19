//
//  DateFormatters.swift
//  Bookworm
//
//  Created by CypherPoet on 11/19/19.
// ✌️
//

import Foundation


enum DateFormatters {
    
    static let bookDetailsReviewDate: DateFormatter = {
        var formatter = DateFormatter()
        
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        
        return formatter
    }()
}
