//
//  Payload+OrbitParams.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import Foundation



extension Payload {
    
    struct OrbitParams {
        typealias Kilometers = Double
        
        var referenceSystem: String?
        var regime: String?
        var longitude: Double?
        
        var periapsis: Kilometers?
        var apoapsis: Kilometers?
        
        /// https://en.wikipedia.org/wiki/Epoch_(astronomy)
        var epoch: Date?
        
        /// https://en.wikipedia.org/wiki/Mean_anomaly
        var meanAnomaly: Double?
        
        var lifeSpanYears: Double?
        
        /// https://en.wikipedia.org/wiki/Geosynchronous_orbit#Properties
        var periodMinutes: Double?
    }
}


extension Payload.OrbitParams: Codable {
    
    enum CodingKeys: String, CodingKey {
        case referenceSystem = "reference_system"
        case regime
        case longitude
        case periapsis = "periapsis_km"
        case apoapsis = "apoapsis_km"
        case epoch
        case meanAnomaly = "mean_anomaly"
        case lifeSpanYears = "lifespan_years"
        case periodMinutes = "period_min"
    }
}
