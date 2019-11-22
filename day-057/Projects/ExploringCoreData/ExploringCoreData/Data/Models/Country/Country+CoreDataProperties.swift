//
//  Country+CoreDataProperties.swift
//  ExploringCoreData
//
//  Created by Brian Sipple on 11/22/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?
    @NSManaged public var flag: String?
    @NSManaged public var abbreviation: String?
    @NSManaged public var candies: NSSet?

}

// MARK: Generated accessors for candies
extension Country {

    @objc(addCandiesObject:)
    @NSManaged public func addToCandies(_ value: Candy)

    @objc(removeCandiesObject:)
    @NSManaged public func removeFromCandies(_ value: Candy)

    @objc(addCandies:)
    @NSManaged public func addToCandies(_ values: NSSet)

    @objc(removeCandies:)
    @NSManaged public func removeFromCandies(_ values: NSSet)

}
