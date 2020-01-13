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


extension Contact: ContactQRCodeRepresentable {
    @NSManaged public var qrCodeData: Data?
    
    @NSManaged public var statusValue: Int16
    
    var status: Status {
        get { Contact.Status(rawValue: statusValue)! }
        set { statusValue = newValue.rawValue }
    }
    
    
    // MARK: - ContactQRCodeRepresentable
    @NSManaged public var name: String
    @NSManaged public var uuid: UUID
}
