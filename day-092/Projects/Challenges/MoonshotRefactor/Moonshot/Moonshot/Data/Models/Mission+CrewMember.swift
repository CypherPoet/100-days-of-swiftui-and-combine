//
//  CrewRole.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import SwiftUI


extension Mission {
    
    struct CrewMember {
        let name: String
        let role: String
    }
}


extension Mission.CrewMember: Codable {}
extension Mission.CrewMember: Hashable {}
