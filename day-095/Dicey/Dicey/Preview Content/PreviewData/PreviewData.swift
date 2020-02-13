//
//  PreviewData.swift
//  Dicey
//
//  Created by CypherPoet on 2/1/20.
// ✌️
//

import Foundation
import CoreData


enum PreviewData {
    
    static func setupSimulatorPreviewData(in context: NSManagedObjectContext) {
        (1...10).map { day in
            let diceRoll = DiceRoll(context: context)
            
            diceRoll.diceValues = [
                Dice.allCases.randomElement()!.rawValue,
                Dice.allCases.randomElement()!.rawValue,
                Dice.allCases.randomElement()!.rawValue,
                Dice.allCases.randomElement()!.rawValue,
            ]
            
            diceRoll.createdAt = Date.init(timeIntervalSince1970: 60 * 60 * 24 * Double(day))
        }
        
        _ = CurrentApp.coreDataManager.save(context)
    }
}
