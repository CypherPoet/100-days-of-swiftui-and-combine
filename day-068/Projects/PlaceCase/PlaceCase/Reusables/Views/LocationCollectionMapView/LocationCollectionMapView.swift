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
    var annotations: [MKPointAnnotation] = []
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
}


// MARK: - UIViewRepresentable
extension LocationCollectionMapView: UIViewRepresentable {

    func makeCoordinator() -> LocationCollectionMapView.Coordinator {
        Self.Coordinator(centerCoordinate: $centerCoordinate)
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
        // TODO
        
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
