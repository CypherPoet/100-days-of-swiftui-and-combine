//
//  Candy+Comparable.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/22/19.
// ✌️
//

import Foundation


extension Candy: Comparable {
    
    public static func < (lhs: Candy, rhs: Candy) -> Bool {
        // Assign a lower sort priority if `name` doesn't exist
        guard let lhsName = lhs.name else { return false }
        guard let rhsName = rhs.name else { return true }

        return lhsName < rhsName
    }
}
