//
//  DiceRoll+Computeds.swift
//  Dicey
//
//  Created by CypherPoet on 2/1/20.
// ✌️
//

import Foundation


extension DiceRoll {
    
    var diceArray: [Dice] {
        diceValues.compactMap(Dice.init(rawValue:))
    }
    
    
    var rollResult: Int {
        diceArray.reduce(0) { (accumulated, current) in
            accumulated + Int(current.rawValue)
        }
    }
}
