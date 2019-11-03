//
//  Mission.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import SwiftUI


struct Mission: Identifiable {
    var id: Int
    var crew: [CrewMember]
    var description: String
    var launchDate: Date?
}

extension Mission: Codable {}
extension Mission: Hashable {}


// MARK: - Computeds
extension Mission {
    var displayName: String { "Apollo \(id)" }
    var imageName: String { "apollo\(id)"}
    
    var formattedLaunchDate: String {
        guard let launchDate = launchDate else { return "N/A" }
        
        return DateFormatters.missionLaunchDate.string(from: launchDate)
    }
}
