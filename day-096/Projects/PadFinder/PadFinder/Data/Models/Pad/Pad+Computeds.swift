//
//  Pad+Computeds.swift
//  PadFinder
//
//  Created by CypherPoet on 1/28/20.
// ✌️
//

import Foundation
import UIKit
import CoreLocation


extension Pad {
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    
    
    func snapshotCacheKey(from size: CGSize) -> String {
        "Snapshot Key (\(size.width) X \(size.height))) :: " +
        "Pad \(id) :: " +
        "Latitude: \(latitude), Longitude: \(longitude)"
    }
}

