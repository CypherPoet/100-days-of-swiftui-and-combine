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

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var longDescription: String?
    
    @NSManaged public var collection: LocationCollection?
    @NSManaged public var wikiPages: NSSet?
}

// MARK: Generated accessors for wikiPages
extension Location {

    @objc(addWikiPagesObject:)
    @NSManaged public func addToWikiPages(_ value: WikiPage)

    @objc(removeWikiPagesObject:)
    @NSManaged public func removeFromWikiPages(_ value: WikiPage)

    @objc(addWikiPages:)
    @NSManaged public func addToWikiPages(_ values: NSSet)

    @objc(removeWikiPages:)
    @NSManaged public func removeFromWikiPages(_ values: NSSet)

}
