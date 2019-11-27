//
//  Payload+CoreDataClass.swift
//  SpaceXPayloadStats
//
//  Created by Brian Sipple on 11/25/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Payload)
public class Payload: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case payloadID = "payload_id"
        case payloadType = "payload_type"
        case isReused = "reused"
        case manufacturer
        case customers
        case nationality
        case mass = "payload_mass_kg"
        case orbit
        case orbitParams = "orbit_params"
    }
    
    
    // MARK: - Decodable
    public required convenience init(from decoder: Decoder) throws {
        guard
            let managedObjectContext = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Payload", in: managedObjectContext)
        else {
            fatalError("Unable to initialize entity during decoding")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        payloadID = try container.decode(String.self, forKey: .payloadID)
        payloadType = try? container.decode(String.self, forKey: .payloadType)
        isReused = try container.decode(Bool.self, forKey: .isReused)
        manufacturer = try? container.decode(String.self, forKey: .manufacturer)
        customers = try? container.decode([String].self, forKey: .customers)
        nationality = try? container.decode(String.self, forKey: .nationality)
        mass = (try? container.decode(Int64.self, forKey: .mass)) ?? 0
        orbit = try? container.decode(String.self, forKey: .orbit)
        orbitParams = try container.decode(OrbitParams.self, forKey: .orbitParams)
    }
}
