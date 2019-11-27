//
//  OrbitParams+CoreDataClass.swift
//  SpaceXPayloadStats
//
//  Created by Brian Sipple on 11/25/19.
//  Copyright © 2019 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OrbitParams)
public class OrbitParams: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case referenceSystem = "reference_system"
        case regime
        case longitude
        case periapsis = "periapsis_km"
        case apoapsis = "apoapsis_km"
        case epoch
        case meanAnomaly = "mean_anomaly"
        case lifespanYears = "lifespan_years"
        case periodMinutes = "period_min"
    }
    
    
    // MARK: - Decodable
    public required convenience init(from decoder: Decoder) throws {
        guard
            let managedObjectContext = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "OrbitParams", in: managedObjectContext)
        else {
            fatalError("Unable to initialize entity during decoding")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
                
        referenceSystem = try? container.decode(String.self, forKey: .referenceSystem)
        regime = try? container.decode(String.self, forKey: .regime)
        longitude = (try? container.decode(Double.self, forKey: .longitude)) ?? 0
        periapsis = (try? container.decode(Kilometers.self, forKey: .periapsis)) ?? 0
        apoapsis = (try? container.decode(Kilometers.self, forKey: .apoapsis)) ?? 0
        epoch = try? container.decode(Date.self, forKey: .epoch)
        meanAnomaly = (try? container.decode(Double.self, forKey: .meanAnomaly)) ?? 0
        lifespanYears = (try? container.decode(Double.self, forKey: .lifespanYears)) ?? 0
        periodMinutes = (try? container.decode(Double.self, forKey: .periodMinutes)) ?? 0
    }
}
