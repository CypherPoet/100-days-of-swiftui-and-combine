//
//  Country+FetchHelpers.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/22/19.
// ✌️
//

import Foundation


extension Country {
    
    public enum SortDescriptor {
        static let byAbbreviation = NSSortDescriptor(keyPath: \Country.abbreviation, ascending: true)
        static let byName = NSSortDescriptor(keyPath: \Country.name, ascending: true)
    }
}
