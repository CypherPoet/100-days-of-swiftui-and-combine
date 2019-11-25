//
//  MissionDetailsViewModel.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/25/19.
// ✌️
//

import SwiftUI


struct MissionDetailsViewModel {
    let mission: Mission
}


// MARK: - Computeds
extension MissionDetailsViewModel {
    var hasPayloads: Bool { !payloadIDs.isEmpty }
    var hasWebLinks: Bool { !webLinks.isEmpty }
    
    var payloadIDs: [Payload.ID] { mission.payloadIDs }
    
    var wikipediaURL: URL? { mission.wikipediaURL }
    var twitterURL: URL? { mission.twitterURL }
    var websiteURL: URL? { mission.websiteURL }
    
    
    var webLinks: [(linkName: String, url: URL)] {
        [
            ("Website", websiteURL),
            ("Wikipedia", wikipediaURL),
            ("Twitter", twitterURL),
        ].compactMap { labelAndURLPair in
            guard let url = labelAndURLPair.1 else { return nil }

            return (labelAndURLPair.0, url)
        }
    }
    
    var missionName: String { mission.name }
    var missionDescription: String { mission.description }
    
}



