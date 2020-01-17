//
//  Contact+SortingState.swift
//  QRConnections
//
//  Created by CypherPoet on 1/16/20.
// ✌️
//

import Foundation



extension Contact {
    public enum SortingState: String {
        case byName
        case byMostRecent
        case byOldestAdded
    }
}

extension Contact.SortingState: CaseIterable {}

extension Contact.SortingState: Identifiable {
    public var id: String { self.rawValue }
}


// MARK: -  Computeds
extension Contact.SortingState {
    
    public var displayName: String {
        switch self {
        case .byName:
            return "By Name"
        case .byMostRecent:
            return "By Most Recent"
        case .byOldestAdded:
            return "By First Added"
        }
    }
}

