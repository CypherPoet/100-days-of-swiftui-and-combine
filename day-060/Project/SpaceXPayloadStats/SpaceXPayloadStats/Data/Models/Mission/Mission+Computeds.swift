//
//  Mission+Computeds.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/25/19.
// ✌️
//

import Foundation


extension Mission {
    
    var payloadsArray: [Payload] {
        guard let payloads = payloads as? Set<Payload> else { return [] }
        
        return payloads.sorted()
    }
    
    
    static var decoder = JSONDecoder()
}
