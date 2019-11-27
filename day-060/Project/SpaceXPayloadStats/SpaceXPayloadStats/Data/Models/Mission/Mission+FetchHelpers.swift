//
//  Mission+FetchHelpers.swift
//  SpaceXPayloadStats
//
//  Created by CypherPoet on 11/27/19.
// ✌️
//

import Foundation
import CoreData


extension Mission {
    
    enum SortDescriptors {
        
        static let `default` = [
            NSSortDescriptor(keyPath: \Mission.name, ascending: true)
        ]
    }

    
    enum FetchRequest {
        
        static let all: NSFetchRequest<Mission> = {
            let fetchRequest: NSFetchRequest<Mission> = Mission.fetchRequest()
            
            fetchRequest.sortDescriptors = Mission.SortDescriptors.default
            
            return fetchRequest
        }()
    }
}


