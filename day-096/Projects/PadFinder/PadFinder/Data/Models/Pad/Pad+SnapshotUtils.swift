//
//  Pad+SnapshotUtils.swift
//  PadFinder
//
//  Created by CypherPoet on 1/27/20.
// ✌️
//

import Foundation
import MapKit


extension Pad {
    
    var baseSnapshotOptions: MKMapSnapshotter.Options {
        let options = MKMapSnapshotter.Options()
        
        options.mapType = .standard
        options.scale = UIScreen.main.scale
        
        options.showsBuildings = true
        //        options.pointOfInterestFilter = .init(including: [.airport, .cafe])
        options.pointOfInterestFilter = .includingAll

        return options
    }
}
