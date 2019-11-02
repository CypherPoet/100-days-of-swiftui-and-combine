//
//  MissionDecoder.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import Foundation



enum MissionDecoder {
    static let `default`: JSONDecoder = {
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .formatted(DateFormatters.missionLaunchDecoding)

        return decoder
    }()
}
