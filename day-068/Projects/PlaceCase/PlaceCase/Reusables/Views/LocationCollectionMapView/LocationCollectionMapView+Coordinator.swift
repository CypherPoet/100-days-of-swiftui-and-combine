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
        @Binding var selectedLocation: Location?

        
        init(
            centerCoordinate: Binding<CLLocationCoordinate2D>,
            selectedLocation: Binding<Location?>
        ) {
            self._centerCoordinate = centerCoordinate
            self._selectedLocation = selectedLocation
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
    
    private func configure(_ annotationView: MKPinAnnotationView) {
        annotationView.canShowCallout = true
        annotationView.isEnabled = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        annotationView.pinTintColor = .systemPink
    }
}


// MARK: - MKMapViewDelegate
extension LocationCollectionMapView.Coordinator: MKMapViewDelegate {
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        centerCoordinate = mapView.centerCoordinate
    }
    
    
    func mapView(
        _ mapView: MKMapView,
        viewFor annotation: MKAnnotation
    ) -> MKAnnotationView? {
        guard annotation is LocationAnnotation else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: ReuseIdentifier.pinAnnotation
        ) as? MKPinAnnotationView
            ?? MKPinAnnotationView(annotation: annotation, reuseIdentifier: ReuseIdentifier.pinAnnotation)
        
        
        configure(annotationView)

        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard
            let annotation = view.annotation as? Location
        else { return }
        
        self.selectedLocation = annotation
    }
}
