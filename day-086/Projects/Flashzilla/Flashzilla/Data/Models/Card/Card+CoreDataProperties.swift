//
//  Card+CoreDataProperties.swift
//  Flashzilla
//
//  Created by Brian Sipple on 1/19/20.
//  Copyright © 2020 CypherPoet. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var prompt: String?
    @NSManaged public var answer: String?
    @NSManaged public var decks: NSSet?

    
    @NSManaged public var answerStateValue: Int16
    
    var answerState: Card.AnswerState {
        get { Card.AnswerState(rawValue: answerStateValue)! }
        set { answerStateValue = newValue.rawValue }
    }
}


// MARK: Generated accessors for decks
extension Card {

    @objc(addDecksObject:)
    @NSManaged public func addToDecks(_ value: CardDeck)

    @objc(removeDecksObject:)
    @NSManaged public func removeFromDecks(_ value: CardDeck)

    @objc(addDecks:)
    @NSManaged public func addToDecks(_ values: NSSet)

    @objc(removeDecks:)
    @NSManaged public func removeFromDecks(_ values: NSSet)

}
