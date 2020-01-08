//
//  LocationCollection+Computeds.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import Foundation


extension LocationCollection {

    var locationsArray: [Location] {
        guard let locations = locations as? Set<Location> else { return [] }
        
        return locations.sorted()
    }
}
