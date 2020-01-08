//
//  LocationCollectionMapView.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/5/19.
// ✌️
//


import SwiftUI
import MapKit


struct LocationCollectionMapView {
    var annotations: [LocationAnnotation] = []
    var startingCenterCoordinate: CLLocationCoordinate2D?
    
    let onSelectLocation: ((Location) -> Void)?
    let onCenterChanged: ((CLLocationCoordinate2D) -> Void)?
}


// MARK: - UIViewRepresentable
extension LocationCollectionMapView: UIViewRepresentable {

    func makeCoordinator() -> LocationCollectionMapView.Coordinator {
        Self.Coordinator(
            onSelectLocation: onSelectLocation,
            onCenterChanged: onCenterChanged
        )
    }


    func makeUIView(
        context: UIViewRepresentableContext<LocationCollectionMapView>
    ) -> MKMapView {
        let mapView = MKMapView()
        
        
        mapView.addAnnotations(annotations)
        mapView.delegate = context.coordinator
        
        return mapView
    }


    func updateUIView(
        _ mapView: MKMapView,
        context: UIViewRepresentableContext<LocationCollectionMapView>
    ) {
        if mapView.annotations.count != annotations.count {
            mapView.removeAnnotations(mapView.annotations)
            mapView.addAnnotations(annotations)
        }
        
        if let startingCenterCoordinate = startingCenterCoordinate {
            mapView.setCenter(startingCenterCoordinate, animated: true)
        }
    }
}



// MARK: - Preview
//struct MapView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        LocationCollectionMapView(
//            annotations: [SampleData.Annotations.santorini],
//            centerCoordinate: .constant(SampleData.Annotations.santorini.coordinate)
//        )
//    }
//}
