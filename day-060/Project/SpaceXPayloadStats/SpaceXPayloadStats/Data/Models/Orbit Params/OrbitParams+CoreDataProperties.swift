//
//  OrbitParams+CoreDataProperties.swift
//  SpaceXPayloadStats
//
//  Created by Brian Sipple on 11/25/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension OrbitParams {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrbitParams> {
        return NSFetchRequest<OrbitParams>(entityName: "OrbitParams")
    }
    
    public typealias Kilometers = Double

    @NSManaged public var apoapsis: Kilometers
    @NSManaged public var epoch: Date?
    @NSManaged public var lifespanYears: Double
    @NSManaged public var longitude: Double
    @NSManaged public var meanAnomaly: Double
    @NSManaged public var periapsis: Kilometers
    @NSManaged public var periodMinutes: Double
    @NSManaged public var referenceSystem: String?
    @NSManaged public var regime: String?
    
    @NSManaged public var payload: Payload?
}
