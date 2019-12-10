//
//  MapView +Coordinator.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/5/19.
// ✌️
//

import Foundation
import UIKit
import SwiftUI
import MapKit


extension LocationCollectionMapView {

    class Coordinator: NSObject {
        @Binding var centerCoordinate: CLLocationCoordinate2D
        
        
        init(centerCoordinate: Binding<CLLocationCoordinate2D>) {
            self._centerCoordinate = centerCoordinate
        }
    }
}


// MARK: - ReuseIdentifier
extension LocationCollectionMapView.Coordinator {
    enum ReuseIdentifier {
        static let pinAnnotation = "Location List Pin"
    }
}


// MARK: - Private Helpers
extension LocationCollectionMapView.Coordinator {
    
    private func configure(_ annotationView: MKAnnotationView) {
        annotationView.canShowCallout = true
        annotationView.isEnabled = true
    }
}


// MARK: - MKMapViewDelegate
extension LocationCollectionMapView.Coordinator: MKMapViewDelegate {
    
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        
        let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: ReuseIdentifier.pinAnnotation
        )
        ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: ReuseIdentifier.pinAnnotation)
        
        
        configure(annotationView)
        
        return annotationView
    }
    

    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        centerCoordinate = mapView.centerCoordinate
    }
}
