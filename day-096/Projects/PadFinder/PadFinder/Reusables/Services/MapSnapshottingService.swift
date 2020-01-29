//
//  MapSnapshottingService.swift
//  PadFinder
//
//  Created by CypherPoet on 1/28/20.
// ✌️
//

import Foundation
import MapKit


final class MapSnapshottingService: MapSnapshotServicing {
    var snapshotOptions: MKMapSnapshotter.Options
    var queue: DispatchQueue
    
    
    init(
        snapshotOptions: MKMapSnapshotter.Options = .init(),
        queue: DispatchQueue = DispatchQueue(label: "Map Snapshotting Service", qos: .default)
    ) {
        self.snapshotOptions = snapshotOptions
        self.queue = queue
    }
}
