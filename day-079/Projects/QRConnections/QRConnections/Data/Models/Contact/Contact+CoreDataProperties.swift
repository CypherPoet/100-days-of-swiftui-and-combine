//
//  Contact+CoreDataProperties.swift
//  QRConnections
//
//  Created by Brian Sipple on 1/10/20.
//  Copyright © 2020 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {
    @NSManaged public var uuid: UUID?
    @NSManaged public var name: String?
    
    @NSManaged public var statusValue: Int16
    
    
    var status: Status {
        get { Contact.Status(rawValue: statusValue)! }
        set { statusValue = newValue.rawValue }
    }
}
