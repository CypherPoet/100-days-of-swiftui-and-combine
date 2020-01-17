//
//  Contact+Status.swift
//  QRConnections
//
//  Created by CypherPoet on 1/10/20.
// ✌️
//

import Foundation


extension Contact {
    public enum Status: Int16 {
        case contacted
        case uncontacted
    }
}

extension Contact.Status: CaseIterable {}


extension Contact.Status {

    var sfSymbolName: String {
        switch self {
        case .contacted:
            return "person.crop.circle.badge.checkmark"
        case .uncontacted:
            return "person.crop.circle.badge.xmark"
        }
    }
}
