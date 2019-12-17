//
//  WikiPage+CoreDataClass.swift
//  PlaceCase
//
//  Created by Brian Sipple on 12/15/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WikiPage)
public class WikiPage: NSManagedObject, Identifiable, Decodable {
    
    enum RootCodingKeys: String, CodingKey {
        case title
        case terms
        case coordinates
    }
    
    enum CoordinatesCodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
    
    
    // MARK: - Decodable
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Missing or invalid managed object context")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "WikiPage", in: context) else {
            fatalError("Unable to initialize \"WikiPage\" entity description in context.")
        }
        
        self.init(entity: entity, insertInto: context)
        
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        
        title = try rootContainer.decode(String.self, forKey: .title)
        terms = try rootContainer.decodeIfPresent([String: [String]].self, forKey: .terms)

        var coordinatesArrayContainer = try rootContainer.nestedUnkeyedContainer(forKey: .coordinates)

        let coordinatesContainer = try coordinatesArrayContainer.nestedContainer(keyedBy: CoordinatesCodingKeys.self)
        
        latitude = try coordinatesContainer.decode(Double.self, forKey: .latitude)
        longitude = try coordinatesContainer.decode(Double.self, forKey: .longitude)
    }
}
