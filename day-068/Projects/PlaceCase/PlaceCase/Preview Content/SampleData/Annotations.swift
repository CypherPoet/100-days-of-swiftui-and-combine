//
//  Annotations.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/6/19.
// ✌️
//

#if DEBUG

import Foundation
import MapKit


enum SampleData {}


extension SampleData {
    
    enum Annotations {
        
        static let santorini: MKPointAnnotation = {
            let annotation = MKPointAnnotation()
            
            annotation.title = "Santorini"
            annotation.subtitle = "An an island in the southern Aegean Sea, speculated to be the inspiration for the city of Atlantis."
            annotation.coordinate = CLLocationCoordinate2D(latitude: 36.416667, longitude: 25.433333)
            
            return annotation
        }()
    }
}


#endif
