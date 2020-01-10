//
//  Contact+Status.swift
//  QRConnections
//
//  Created by CypherPoet on 1/10/20.
// ✌️
//

import Foundation


extension Contact {
    enum Status: Int16 {
        case contacted
        case uncontacted
    }
}


extension Contact.Status: CaseIterable {}
