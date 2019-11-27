//
//  Payload+Comparable.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/25/19.
// ✌️
//

import Foundation


extension Payload: Comparable {
    
    public static func < (lhs: Payload, rhs: Payload) -> Bool {
        // Assign a lower sort priority if `payloadID` doesn't exist
        guard let lhsID = lhs.payloadID else { return false }
        guard let rhsID = rhs.payloadID else { return true }

        return lhsID < rhsID
    }
}
