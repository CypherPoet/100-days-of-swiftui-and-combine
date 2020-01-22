//
//  CardDeck+Computeds.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/21/20.
// ✌️
//

import Foundation


extension CardDeck {
    var cardsArray: [Card] {
        guard let cardSet = cards as? Set<Card> else { return [] }
        
        return Array(cardSet)
    }
}

