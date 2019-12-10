//
//  LocationCollection+CoreDataProperties.swift
//  PlaceCase
//
//  Created by Brian Sipple on 12/6/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension LocationCollection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationCollection> {
        return NSFetchRequest<LocationCollection>(entityName: "LocationCollection")
    }

    @NSManaged public var title: String?
    @NSManaged public var locations: NSSet?
}


// MARK: Generated accessors for locations
extension LocationCollection {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: Location)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: Location)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}
