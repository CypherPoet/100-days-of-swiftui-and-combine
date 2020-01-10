//
//  Contact+FetchHelpers.swift
//  QRConnections
//
//  Created by CypherPoet on 1/10/20.
// ✌️
//

import Foundation
import CoreData
import CypherPoetCoreDataKit_PredicateUtils


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }
    
    
    enum SortDescriptors {
        static let `default` = [
            NSSortDescriptor(keyPath: \Contact.name, ascending: true)
        ]
    }
    
    
    enum Predicate {
        
        static func contacts(for status: Status) -> NSPredicate {
            let keyword = NSComparisonPredicate.keyword(for: .equalTo)
            
            return NSPredicate(
                format: "%K \(keyword) %d",
                #keyPath(Contact.statusValue),
                status.rawValue
            )
        }
    }
    
    
    
    static func fetchRequest(for filterState: FilterState) -> NSFetchRequest<Contact> {
        let fetchRequest: NSFetchRequest<Contact> = Self.fetchRequest()
        
        fetchRequest.sortDescriptors = Self.SortDescriptors.default
        
        if let status = filterState.contactStatus {
            fetchRequest.predicate = Self.Predicate.contacts(for: status)
        }
        
        return fetchRequest
    }

}
