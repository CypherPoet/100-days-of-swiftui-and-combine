//
//  Endpoint+SpaceXAPI.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import Foundation
import CypherPoetNetStack


extension Endpoint {

    enum SpaceXAPI {
        static let host = "api.spacexdata.com"
        
        public static let missions = Endpoint(
            host: Self.host,
            path: "/v3/missions"
        )
        
        public static func payload(for payloadID: String) -> Endpoint {
            Endpoint(
                host: Self.host,
                path: "/v3/payloads/\(payloadID)"
            )
        }
    }
}
