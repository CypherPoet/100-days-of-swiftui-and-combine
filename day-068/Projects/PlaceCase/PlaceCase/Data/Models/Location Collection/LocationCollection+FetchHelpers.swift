//
//  LocationCollection+FetchHelpers.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import Foundation
import CoreData


extension LocationCollection {

    enum SortDescriptors {
        static let `default` = [
            NSSortDescriptor(keyPath: \LocationCollection.title, ascending: true)
        ]
    }
    
    
    enum FetchRequest {
        
        static let all: NSFetchRequest<LocationCollection> = {
            let fetchRequest: NSFetchRequest<LocationCollection> = LocationCollection.fetchRequest()
            
            fetchRequest.sortDescriptors = SortDescriptors.default
            
            return fetchRequest
        }()
    }
}

