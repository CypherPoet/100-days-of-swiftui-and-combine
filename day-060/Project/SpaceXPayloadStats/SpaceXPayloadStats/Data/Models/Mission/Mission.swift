//
//  Mission.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/23/19.
// ✌️
//

import Foundation


struct Mission {
    var missionID: String
    var name: String
    var manufacturers: [String]
    var payloadIds: [String]
    var wikipediaURL: URL
    var websiteURL: URL
    var twitterURL: URL
    var description: String
}


extension Mission: Identifiable {
    var id: String { missionID }
}


extension Mission: Codable {
    
    enum CodingKeys: String, CodingKey {
        case missionID = "mission_id"
        case name = "mission_name"
        case manufacturers
        case payloadIds = "payload_ids"
        case wikipediaURL = "wikipedia"
        case websiteURL = "website"
        case twitterURL = "twitter"
        case description
    }
}
