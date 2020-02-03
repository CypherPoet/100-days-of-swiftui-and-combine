//
//  Dice+Computeds.swift
//  Dicey
//
//  Created by CypherPoet on 2/1/20.
// ✌️
//

import Foundation


extension Dice {
    
    var imageName: String {
        switch self {
        case .one:
            return "dice-1"
        case .two:
            return "dice-2"
        case .three:
            return "dice-3"
        case .four:
            return "dice-4"
        case .five:
            return "dice-5"
        case .six:
            return "dice-6"
        }
    }
}
