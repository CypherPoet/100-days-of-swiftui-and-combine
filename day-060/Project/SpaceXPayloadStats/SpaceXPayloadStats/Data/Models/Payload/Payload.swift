//
//  Payload.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import Foundation



struct Payload {
    typealias Kilograms = Int
    
    var payloadID: String
    var payloadType: String
    var isReused: Bool
    var manufacturer: String
    var customers: [String]
    var nationality: String
    var mass: Kilograms
    var oribit: String
    var orbitParams: OrbitParams
}


extension Payload: Identifiable {
    var id: String { payloadID }
}


extension Payload: Codable {
    enum CodingKeys: String, CodingKey {
        
        case payloadID = "payload_id"
        case payloadType = "payload_type"
        case isReused = "reused"
        case manufacturer
        case customers
        case nationality
        case mass = "payload_mass_kg"
        case oribit
        case orbitParams = "orbit_params"
    }
}
