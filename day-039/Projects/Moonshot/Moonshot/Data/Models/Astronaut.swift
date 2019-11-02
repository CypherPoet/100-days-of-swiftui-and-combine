//
//  Astronaut.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import SwiftUI


struct Astronaut: Identifiable {
    let id: String
    let name: String
    let description: String
}


extension Astronaut: Codable {}
