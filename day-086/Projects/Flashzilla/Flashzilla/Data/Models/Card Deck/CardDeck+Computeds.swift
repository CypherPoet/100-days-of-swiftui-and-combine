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
    

    var correctAnswerCount: Int {
        cardsArray.reduce(0) { (sum, card) in
            card.answerState == .correct ? sum + 1 : sum
        }
    }
    
    var incorrectAnswerCount: Int {
        cardsArray.reduce(0) { (sum, card) in
            card.answerState == .incorrect ? sum + 1 : sum
        }
    }
    
    var unansweredCount: Int {
        cardsArray.reduce(0) { (sum, card) in
            card.answerState == .unanswered ? sum + 1 : sum
        }
    }
}


