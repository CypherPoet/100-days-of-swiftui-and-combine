//
//  Mission+CoreDataClass.swift
//  SpaceXPayloadStats
//
//  Created by Brian Sipple on 11/25/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Mission)
public class Mission: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case missionID = "mission_id"
        case name = "mission_name"
        case manufacturers
        case payloadIDs = "payload_ids"
        case wikipediaURLString = "wikipedia"
        case websiteURLString = "website"
        case twitterURLString = "twitter"
        case missionDescription = "description"
    }
    
        
    // MARK: - Decodable
    public required convenience init(from decoder: Decoder) throws {
        guard
            let managedObjectContext = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Mission", in: managedObjectContext)
        else {
            fatalError("Unable to initialize entity during decoding")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
                
        missionID = try container.decode(String.self, forKey: .missionID)
        name = try container.decode(String.self, forKey: .name)
        manufacturers = try container.decode([String].self, forKey: .manufacturers)
        payloadIDs = try container.decode([String].self, forKey: .payloadIDs)
        wikipediaURLString = try? container.decode(String.self, forKey: .wikipediaURLString)
        websiteURLString = try? container.decode(String.self, forKey: .websiteURLString)
        twitterURLString = try? container.decode(String.self, forKey: .twitterURLString)
        missionDescription = try container.decode(String.self, forKey: .missionDescription)
    }
}

