//
//  LocationAnnotation.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import MapKit


/// 🔑 This protocol doesn't extend `MKAnnotation` in any way, but it
/// will allow us to distinguish our own location annotations
/// from those belonging to `MapKit`.
protocol LocationAnnotation: MKAnnotation {}

