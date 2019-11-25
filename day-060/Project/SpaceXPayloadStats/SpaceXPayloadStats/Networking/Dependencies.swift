//
//  Dependencies.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import Foundation


enum Dependencies {
    static let spaceXAPIService = SpaceXAPIService(
        queue: DispatchQueue(
            label: "SpaceX API Service",
            qos: .userInitiated,
            attributes: [.concurrent]
        )
    )
}
