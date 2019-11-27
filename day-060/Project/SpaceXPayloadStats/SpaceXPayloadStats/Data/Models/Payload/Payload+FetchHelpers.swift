//
//  Payload+FetchHelpers.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/27/19.
// ✌️
//

import Foundation
import CoreData
import CypherPoetCoreDataKit_PredicateUtils


extension Payload {
    
    enum SortDescriptors {
        
        static let `default` = [
            NSSortDescriptor(keyPath: \Payload.payloadID, ascending: true)
        ]
    }
    
    
    enum Predicate {
        
        static func payloads(for mission: Mission) -> NSPredicate {
            let keyword = NSComparisonPredicate.keyword(for: .in)
            
            return NSPredicate(
                format: "%K \(keyword) %@",
                #keyPath(Payload.payloadID),
                mission.payloadIDs ?? []
            )
        }
    }
    
    
    static func fetchRequest(for mission: Mission) -> NSFetchRequest<Payload> {
        let fetchRequest: NSFetchRequest<Payload> = Self.fetchRequest()
        
        fetchRequest.sortDescriptors = Self.SortDescriptors.default
        fetchRequest.predicate = Self.Predicate.payloads(for: mission)
        
        return fetchRequest
    }
}
