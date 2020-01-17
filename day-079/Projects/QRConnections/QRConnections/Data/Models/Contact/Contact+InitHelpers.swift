//
//  Contact+InitHelpers.swift
//  QRConnections
//
//  Created by CypherPoet on 1/14/20.
// ✌️
//

import Foundation
import CoreData


extension Contact {
    
    static func make(
        fromName name: String,
        andStatus status: Status = .uncontacted,
        using context: NSManagedObjectContext
    ) -> Contact {
        let contact = Contact(context: context)
        
        contact.name = name
        contact.status = status

        contact.uuid = UUID()
        contact.dateAdded = Date()
        
        return contact
    }
}
