//
//  CodingUserInfoKey+Extensions.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/26/19.
// ✌️
//

import Foundation


public extension CodingUserInfoKey {
    
    /// Use for retrieving a Core Data managed object context from the `userInfo` dictionary
    /// of a decoder instance.
    static let managedObjectContext = CodingUserInfoKey(rawValue: "ManagedObjectContext")!
}
