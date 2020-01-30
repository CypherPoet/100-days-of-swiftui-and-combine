//
//  MapSnapshotServicing.swift
//  PadFinder
//
//  Created by CypherPoet on 1/28/20.
// ✌️
//


import SwiftUI
import MapKit
import Combine


protocol MapSnapshotServicing: class {
    var snapshotOptions: MKMapSnapshotter.Options { get }
    var queue: DispatchQueue { get }
    
    func takeSnapshot(
        with size: CGSize,
        at coordinate: CLLocationCoordinate2D,
        latitudeSpan: CLLocationDegrees,
        longitudeSpan: CLLocationDegrees
    ) -> Future<MKMapSnapshotter.Snapshot, Error>
}


extension MapSnapshotServicing {
    
    func takeSnapshot(
        with size: CGSize,
        at coordinate: CLLocationCoordinate2D,
        latitudeSpan: CLLocationDegrees = 1.75,
        longitudeSpan: CLLocationDegrees = 1.75
    ) -> Future<MKMapSnapshotter.Snapshot, Error> {
        let span = MKCoordinateSpan(latitudeDelta: latitudeSpan, longitudeDelta: longitudeSpan)
        
        snapshotOptions.region = MKCoordinateRegion(
            center: coordinate,
            span: span
        )
        
        snapshotOptions.size = size
        
        let snapshotter = MKMapSnapshotter(options: snapshotOptions)
        
        // TOOD: Ideally, we'd implement some kind of cahcing here, or save the images
        // as part of each pad model -- which could be persisted in Core Data.
        return Future { promise in
            snapshotter.start(with: self.queue) { (snapshot, error) in
                guard error == nil else {
                    return promise(.failure(error!))
                }
                
                guard let snapshot = snapshot else {
                    preconditionFailure("No snapshot returned despite snapshotter completing without error.")
                }
                
                return promise(.success(snapshot))
            }
        }
    }
}

