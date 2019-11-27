//
//  Payload+Computeds.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/26/19.
// ✌️
//

import Foundation


extension Payload {
    
    var payloadTypeEmoji: String? {
        guard let type = payloadType?.lowercased() else { return nil }
        
        if type.starts(with: "satellite") {
            return "🛰"
        } else if type.contains("Dragon") {
            return "🚀"
        } else {
            return nil
        }
    }

    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        /// Use a custom date decoding strategy to handle `orbitParams.epoch`, which contain
        /// milliseconds (aka "fractional seconds")
        decoder.dateDecodingStrategy = .iso8601Full

        return decoder
    }()
}
