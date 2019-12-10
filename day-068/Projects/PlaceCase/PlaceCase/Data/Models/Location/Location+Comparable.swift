//
//  Location+Comparable.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import Foundation


extension Location: Comparable {
 
    public static func < (lhs: Location, rhs: Location) -> Bool {
        // Assign a lower sort priority if `name` doesn't exist
        guard let lhsTitle = lhs.title else { return false }
        guard let rhsTitle = rhs.title else { return true }
        
        return lhsTitle < rhsTitle
    }
}
