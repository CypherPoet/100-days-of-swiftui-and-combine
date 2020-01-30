//
//  Pad+Computeds.swift
//  PadFinder
//
//  Created by CypherPoet on 1/28/20.
// ✌️
//

import Foundation
import CoreLocation


extension Pad {
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}

