//
//  Card+FetchHelpers.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/22/20.
// ✌️
//

import Foundation
import CoreData
import CypherPoetCoreDataKit_PredicateUtils


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }
    
    
    public enum SortDescriptors {
    }
    
    
    public enum Predicate {
        
        public static func cards(in cardDeck: CardDeck) -> NSPredicate {
            let keyword = NSComparisonPredicate.keyword(for: .in)
            
            let predicate = NSPredicate(
                format: "%@ \(keyword) %K",
                cardDeck.objectID,
                #keyPath(Card.decks)
            )
            
            return predicate
        }
    }
    
    
    @nonobjc public class func fetchRequest(
        forCardsIn cardDeck: CardDeck
    ) -> NSFetchRequest<Card> {
        let fetchRequest: NSFetchRequest<Card> = Self.fetchRequest()
        
        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = Self.Predicate.cards(in: cardDeck)
        
        return fetchRequest
    }
}
