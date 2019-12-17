//
//  WikiPage+CoreDataProperties.swift
//  PlaceCase
//
//  Created by Brian Sipple on 12/15/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension WikiPage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WikiPage> {
        return NSFetchRequest<WikiPage>(entityName: "WikiPage")
    }

    @NSManaged public var title: String?
    @NSManaged public var terms: [String: [String]]?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    
    @NSManaged public var location: Location?
}
