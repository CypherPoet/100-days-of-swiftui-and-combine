//
//  DiceRoll+FetchHelpers.swift
//  Dicey
//
//  Created by CypherPoet on 2/13/20.
// ✌️
//

import Foundation
import CoreData


extension DiceRoll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceRoll> {
        return NSFetchRequest<DiceRoll>(entityName: "DiceRoll")
    }
    
    
    public enum SortDescriptors {
        static let mostRecent = NSSortDescriptor(keyPath: \DiceRoll.createdAt, ascending: false)
    }
    
    
    public enum Predicates {
    }
    
    
    public enum FetchRequests {
        static let `default`: NSFetchRequest<DiceRoll> = {
            let fetchRequest: NSFetchRequest<DiceRoll> = DiceRoll.fetchRequest()
            
            fetchRequest.sortDescriptors = [DiceRoll.SortDescriptors.mostRecent]
            fetchRequest.predicate = nil
            
            return fetchRequest
        }()
    }
}
