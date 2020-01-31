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
    typealias SnapshotCache = Cache<String, MKMapSnapshotter.Snapshot>
    
    var snapshotOptions: MKMapSnapshotter.Options { get }
    var queue: DispatchQueue { get }
    var snapshotCache: SnapshotCache { get }

    
    func takeSnapshot(
        cacheKey: String?,
        size: CGSize,
        coordinate: CLLocationCoordinate2D,
        latitudeSpan: CLLocationDegrees,
        longitudeSpan: CLLocationDegrees
    ) -> Future<MKMapSnapshotter.Snapshot, Error>
}


extension MapSnapshotServicing {
    
    func takeSnapshot(
        cacheKey: String? = nil,
        size: CGSize,
        coordinate: CLLocationCoordinate2D,
        latitudeSpan: CLLocationDegrees = 1.75,
        longitudeSpan: CLLocationDegrees = 1.75
    ) -> Future<MKMapSnapshotter.Snapshot, Error> {
        Future { promise in
//            if
//                let cacheKey = cacheKey,
//                let cachedSnapshot = self.snapshotFromCache(key: cacheKey)
//            {
//                return promise(.success(cachedSnapshot))
//            }
            
            let span = MKCoordinateSpan(
                latitudeDelta: latitudeSpan,
                longitudeDelta: longitudeSpan
            )
            
            self.snapshotOptions.region = MKCoordinateRegion(
                center: coordinate,
                span: span
            )
            
            self.snapshotOptions.size = size
            
            let snapshotter = MKMapSnapshotter(options: self.snapshotOptions)
            
            snapshotter.start(with: self.queue) { (snapshot, error) in
                guard let snapshot = snapshot else {
                    return promise(.failure(error!))
                }
                
                if let cacheKey = cacheKey {
                    self.snapshotCache.insert(snapshot, forKey: cacheKey)
                }
                
                return promise(.success(snapshot))
            }
        }
    }
    
    
    func snapshotFromCache(key: String) -> MKMapSnapshotter.Snapshot? {
        snapshotCache.value(forKey: key)
    }
}



