//
//  PreviewData+Cards.swift
//  Flashzilla
//
//  Created by CypherPoet on 1/19/20.
// ✌️
//

import Foundation


extension PreviewData {
    
    enum Cards {
        static let previewCard: Card = {
            let card = Card()
            
            card.prompt = "What is tax?"
            card.answer = "Theft"
            
            return card
        }()
    }
}
