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
    
    
    public enum SortDescriptors {
        public static let byName = NSSortDescriptor(keyPath: \Contact.name, ascending: true)
        public static let byMostRecent = NSSortDescriptor(keyPath: \Contact.dateAdded, ascending: false)
        public static let byOldestAdded = NSSortDescriptor(keyPath: \Contact.dateAdded, ascending: true)
        
        
        public static let `default` = Self.byName
        
        
        public static func forSortingState(_ sortingState: Contact.SortingState) -> [NSSortDescriptor] {
            switch sortingState {
            case .byName:
                return [Self.byName]
            case .byMostRecent:
                return [Self.byMostRecent, byName]
            case .byOldestAdded:
                return [Self.byOldestAdded, byName]
            }
        }
    }
    
    
    public enum Predicate {
        
        public static func contacts(for status: Contact.Status) -> NSPredicate {
            let keyword = NSComparisonPredicate.keyword(for: .equalTo)
            
            return NSPredicate(
                format: "%K \(keyword) %d",
                #keyPath(Contact.statusValue),
                status.rawValue
            )
        }
    }
    
    
    
    @nonobjc public class func fetchRequest(
        filteringOn filterState: FilterState,
        sortingBy sortingState: SortingState
    ) -> NSFetchRequest<Contact> {
        let fetchRequest: NSFetchRequest<Contact> = Self.fetchRequest()
        
        fetchRequest.sortDescriptors = Self.SortDescriptors.forSortingState(sortingState)
        
        if let status = filterState.contactStatus {
            fetchRequest.predicate = Self.Predicate.contacts(for: status)
        }
        
        return fetchRequest
    }
}
