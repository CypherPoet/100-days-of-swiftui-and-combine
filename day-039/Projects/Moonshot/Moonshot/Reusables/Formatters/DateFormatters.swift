//
//  DateFormatters.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import Foundation


enum DateFormatters {
    
    static let missionLaunchDecoding: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "y-MM-dd"
        
        return formatter
    }()
    
    static let missionLaunchDate: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        
        return formatter
    }()
}
