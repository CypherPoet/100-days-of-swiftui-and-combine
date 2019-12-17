//
//  WikiPage+Comparable.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/15/19.
// ✌️
//

extension WikiPage: Comparable {
 
    public static func < (lhs: WikiPage, rhs: WikiPage) -> Bool {
        // Assign a lower sort priority if `title` doesn't exist
        guard let lhsTitle = lhs.title else { return false }
        guard let rhsTitle = rhs.title else { return true }
        
        return lhsTitle < rhsTitle
    }
}

