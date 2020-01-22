//
//  PreviewData+Cards.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import Foundation
import CoreData


extension PreviewData {
    
    enum Cards {
        static let card1: Card = {
            let card = Card(context: CurrentApp.coreDataManager.mainContext)
            
            card.prompt = "What is another word for taxation?"
            card.answer = "Theft"
            card.answerState = .unanswered
            
            return card
        }()
        
        
        static let card2: Card = {
            let card = Card(context: CurrentApp.coreDataManager.mainContext)
            
            card.prompt = "What is the name of our closest galaxy?"
            card.answer = "Andromeda"
            card.answerState = .unanswered
            
            return card
        }()
        
        
        static let card3: Card = {
            let card = Card(context: CurrentApp.coreDataManager.mainContext)
            
            card.prompt = "Who invented calculus?"
            card.answer = "Issac Netwon"
            card.answerState = .unanswered
            
            return card
        }()
        
        
        static let `default` = card1
        
    }
}


extension PreviewData {
    
    enum CardDecks {
        static let `default`: CardDeck = {
            let deck = CardDeck(context: CurrentApp.coreDataManager.mainContext)

            deck.name = "Preview Deck"
            
            for card in [PreviewData.Cards.card3, PreviewData.Cards.card1, PreviewData.Cards.card2] {
                deck.addToCards(card)
            }

            return deck
        }()
    }
}
