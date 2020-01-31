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
    var snapshotCache: MapSnapshotServicing.SnapshotCache
    var queue: DispatchQueue
    
    
    static var sharedSnapshotCache: MapSnapshotServicing.SnapshotCache = .init()
    
    
    init(
        snapshotOptions: MKMapSnapshotter.Options = .init(),
        snapshotCache: MapSnapshotServicing.SnapshotCache = sharedSnapshotCache,
        queue: DispatchQueue = DispatchQueue(label: "Map Snapshotting Service", qos: .default)
    ) {
        self.snapshotOptions = snapshotOptions
        self.snapshotCache = snapshotCache
        self.queue = queue
    }
}
