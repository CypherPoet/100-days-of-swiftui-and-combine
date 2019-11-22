//
//  Country+Computeds.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/22/19.
// ✌️
//

import Foundation


extension Country {

    var wrappedName: String { name ?? "Unknown Name" }
    var wrappedAbbreviation: String { abbreviation ?? "Unknown Abbreviation" }
    var wrappedFlag: String { flag ?? "" }
    
    
    var candiesArray: [Candy] {
        let candies = self.candies as? Set<Candy> ?? []
        
        return candies.sorted()
    }
}
