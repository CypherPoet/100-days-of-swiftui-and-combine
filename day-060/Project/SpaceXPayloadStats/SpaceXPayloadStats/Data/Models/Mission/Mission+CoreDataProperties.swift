//
//  Mission+CoreDataProperties.swift
//  SpaceXPayloadStats
//
//  Created by Brian Sipple on 11/25/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension Mission {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mission> {
        return NSFetchRequest<Mission>(entityName: "Mission")
    }

    @NSManaged public var manufacturers: [String]?
    @NSManaged public var missionDescription: String?
    @NSManaged public var missionID: String?
    @NSManaged public var name: String?
    @NSManaged public var payloadIDs: [String]?
    @NSManaged public var twitterURLString: String?
    @NSManaged public var websiteURLString: String?
    @NSManaged public var wikipediaURLString: String?

    @NSManaged public var payloads: NSSet?

}

// MARK: Generated accessors for payloads
extension Mission {

    @objc(addPayloadsObject:)
    @NSManaged public func addToPayloads(_ value: Payload)

    @objc(removePayloadsObject:)
    @NSManaged public func removeFromPayloads(_ value: Payload)

    @objc(addPayloads:)
    @NSManaged public func addToPayloads(_ values: NSSet)

    @objc(removePayloads:)
    @NSManaged public func removeFromPayloads(_ values: NSSet)

}
