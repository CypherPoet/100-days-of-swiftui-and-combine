//
//  Ship+CoreDataProperties.swift
//  ExploringCoreData
//
//  Created by Brian Sipple on 11/21/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension Ship {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ship> {
        return NSFetchRequest<Ship>(entityName: "Ship")
    }

    @NSManaged public var name: String?
    @NSManaged public var universeValue: Int32

    
    var universe: Ship.Universe {
        get { Ship.Universe(rawValue: universeValue)! }
        set { universeValue = newValue.rawValue }
    }
}
