//
//  Payload+CoreDataProperties.swift
//  SpaceXPayloadStats
//
//  Created by Brian Sipple on 11/25/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension Payload {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payload> {
        return NSFetchRequest<Payload>(entityName: "Payload")
    }

    @NSManaged public var customers: [String]?
    @NSManaged public var isReused: Bool
    @NSManaged public var manufacturer: String?
    @NSManaged public var mass: Int64
    @NSManaged public var nationality: String?
    @NSManaged public var orbit: String?
    @NSManaged public var payloadID: String?
    @NSManaged public var payloadType: String?
    
    @NSManaged public var mission: Mission?
    @NSManaged public var orbitParams: OrbitParams?
}
