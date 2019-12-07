//
//  MapView.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/5/19.
// ✌️
//


import SwiftUI
import MapKit


struct MapView {
    var annotations: [MKPointAnnotation] = []
}


// MARK: - UIViewRepresentable
extension MapView: UIViewRepresentable {

    func makeCoordinator() -> MapView.Coordinator {
        Self.Coordinator()
    }


    func makeUIView(
        context: UIViewRepresentableContext<MapView>
    ) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.addAnnotations(annotations)
        mapView.delegate = context.coordinator
        
        return mapView
    }


    func updateUIView(
        _ mapView: MKMapView,
        context: UIViewRepresentableContext<MapView>
    ) {
        // TODO
        
    }
}



// MARK: - Preview
struct MapView_Previews: PreviewProvider {

    static var previews: some View {
        MapView(
            annotations: [SampleData.Annotations.santorini]
        )
    }
}
