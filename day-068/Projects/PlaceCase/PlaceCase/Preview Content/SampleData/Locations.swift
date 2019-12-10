//
//  Locations.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/6/19.
// ✌️
//

#if DEBUG

import Foundation


extension SampleData {
    
    enum Locations {
        
        static let santorini: Location = {
            let location = Location(context: CoreDataManager.shared.mainContext)
        
            location.title = "Santorini"
            location.subtitle = "An an island in the southern Aegean Sea, speculated to be the inspiration for the city of Atlantis."
            
            location.latitude = 36.416667
            location.longitude = 25.433333
            
            return location
        }()
    }
}


#endif
