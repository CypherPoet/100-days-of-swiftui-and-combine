//
//  MapView +Coordinator.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/5/19.
// ✌️
//

import Foundation
import UIKit
import MapKit


extension MapView {

    class Coordinator: NSObject {
        enum ReuseIdentifier {
            static let pinAnnotation = "Location List Pin"
        }
    }
}


extension MapView.Coordinator {
    
    func configure(_ annotationView: MKAnnotationView) {
        annotationView.canShowCallout = true
        annotationView.isEnabled = true
    }
}


// MARK: - MKMapViewDelegate
extension MapView.Coordinator: MKMapViewDelegate {
    
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
}
