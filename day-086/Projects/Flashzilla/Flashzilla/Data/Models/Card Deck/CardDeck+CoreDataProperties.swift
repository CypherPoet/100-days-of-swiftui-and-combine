//
//  CardDeck+CoreDataProperties.swift
//  Flashzilla
//
//  Created by Brian Sipple on 1/21/20.
//  Copyright © 2020 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension CardDeck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardDeck> {
        return NSFetchRequest<CardDeck>(entityName: "CardDeck")
    }

    @NSManaged public var name: String?
    @NSManaged public var cards: NSSet?
}


// MARK: Generated accessors for cards
extension CardDeck {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: Card)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: Card)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
