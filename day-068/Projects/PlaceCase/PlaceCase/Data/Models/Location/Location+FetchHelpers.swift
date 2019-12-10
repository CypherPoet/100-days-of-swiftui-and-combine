//
//  Location+FetchHelpers.swift
//  PlaceCase
//
//  Created by CypherPoet on 12/8/19.
// ✌️
//

import Foundation
import CoreData
import CypherPoetCoreDataKit_PredicateUtils


extension Location {

    enum SortDescriptors {
        static let `default` = [
            NSSortDescriptor(keyPath: \Location.title, ascending: true)
        ]
    }
    
    
    enum Predicate {
        
        static func locations(for collection: LocationCollection) -> NSPredicate {
            let keyword = NSComparisonPredicate.keyword(for: .equalTo)
            
            return NSPredicate(
                format: "%K \(keyword) %@",
                #keyPath(Location.collection),
                collection
            )
        }
    }
    
    
    
    static func fetchRequest(for collection: LocationCollection) -> NSFetchRequest<Location> {
        let fetchRequest: NSFetchRequest<Location> = Self.fetchRequest()
        
        fetchRequest.sortDescriptors = Self.SortDescriptors.default
        fetchRequest.predicate = Self.Predicate.locations(for: collection)
        
        return fetchRequest
    }

}
