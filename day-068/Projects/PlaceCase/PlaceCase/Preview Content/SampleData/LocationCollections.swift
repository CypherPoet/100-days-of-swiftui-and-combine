//
//  LocationCollections.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import Foundation

#if DEBUG


extension SampleData {
    
    enum LocationCollections {
        static let `default`: LocationCollection = {
            let context = CoreDataManager.shared.mainContext
            let collection = LocationCollection(context: context)
            
            collection.title = "Default Collection"
            collection.addToLocations(SampleData.Locations.santorini)
            
            return collection
        }()
    }
}


#endif
