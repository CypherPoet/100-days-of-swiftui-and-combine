//
//  Contact+FilterState.swift
//  QRConnections
//
//  Created by CypherPoet on 1/9/20.
// ✌️
//

import SwiftUI


extension Contact {
    enum FilterState: String {
        case all
        case contacted
        case uncontacted
    }
}

extension Contact.FilterState: CaseIterable {}

extension Contact.FilterState: Identifiable {
    var id: String { self.rawValue }
}


// MARK: -  Computeds
extension Contact.FilterState {
    
    var displayName: String {
        switch self {
        case .all:
            return "All"
        case .contacted:
            return "Contacted"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    
    var contactStatus: Contact.Status? {
        switch self {
        case .all:
            return nil
        case .contacted:
            return .contacted
        case .uncontacted:
            return .uncontacted
        }
    }
}

