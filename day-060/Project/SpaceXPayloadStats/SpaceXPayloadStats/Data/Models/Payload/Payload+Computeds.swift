//
//  Payload+Computeds.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/24/19.
// ✌️
//

import Foundation


extension Payload {
    
    var payloadTypeEmoji: String? {
        let type = payloadType.lowercased()
        
        if type.starts(with: "satellite") {
            return "🛰"
        } else if type.contains("Dragon") {
            return "🚀"
        } else {
            return nil
        }
    }
}

