//
//  Location+CoreDataProperties.swift
//  PlaceCase
//
//  Created by Brian Sipple on 12/6/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData
import CoreLocation


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var longDescription: String?
    
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    
    @NSManaged public var collection: LocationCollection?
}
