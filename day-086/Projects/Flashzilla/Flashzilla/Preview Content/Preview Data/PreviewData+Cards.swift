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
        
        static let `default`: Card = {
            let card = Card(context: CurrentApp.coreDataManager.mainContext)
            
            card.prompt = "What is another word for taxation?"
            card.answer = "Theft"
            
            return card
        }()
        
        
        static func buildDeck(size: Int = 10) -> [Card] {
            Array(repeating: Cards.default, count: size)
        }
    }
}
