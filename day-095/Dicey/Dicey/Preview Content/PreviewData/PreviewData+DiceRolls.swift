//
//  PreviewData+Dice.swift
//  Dicey
//
//  Created by CypherPoet on 2/3/20.
// ✌️
//

import Foundation


extension PreviewData {
    
    enum DiceRolls {
        
        static let fourDice: DiceRoll = {
            let diceRoll = DiceRoll(context: CurrentApp.coreDataManager.mainContext)
            
            diceRoll.diceValues = [1, 2, 3, 4]
            diceRoll.createdAt = Date()
            
            return diceRoll
        }()
    }
}
