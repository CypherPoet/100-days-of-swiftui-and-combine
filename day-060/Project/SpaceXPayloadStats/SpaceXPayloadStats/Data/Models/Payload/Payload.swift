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
    var orbit: String
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
        case orbit
        case orbitParams = "orbit_params"
    }
}


extension Payload {
    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        /// Use a custom date decoding strategy to handle `orbitParams.epoch`, which contain
        /// milliseconds (aka "fractional seconds")
        decoder.dateDecodingStrategy = .iso8601Full

        return decoder
    }()
}


