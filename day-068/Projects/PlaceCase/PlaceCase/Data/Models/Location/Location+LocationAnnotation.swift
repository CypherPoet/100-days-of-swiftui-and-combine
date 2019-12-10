//
//  Location+CustomAnnotation.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import MapKit


/// Adopt the `LocationAnnotation` protocol so we can drive `MKMapView`s
/// with `Location` entities.
///
/// Similar sentiments are outlined [here](https://www.timekl.com/blog/2017/04/02/putting-core-data-on-the-map/).
extension Location: LocationAnnotation {
    
    public var coordinate: CLLocationCoordinate2D {
        guard
            latitude.isValidLatitude,
            longitude.isValidLongitude
        else {
            return kCLLocationCoordinate2DInvalid
        }
        
        return .init(latitude: latitude, longitude: longitude)
    }
}
