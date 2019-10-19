//
//  GameItem.swift
//  RockPaperQuizzers
//
//  Created by CypherPoet on 10/17/19.
// ✌️
//

import Foundation
import SwiftUI


enum GameItem: String, CaseIterable {
    case rock
    case paper
    case scissors
}
 

// MARK: - Computeds
extension GameItem {
    var displayValue: String { self.rawValue.capitalized }
    
    var image: Image {
        switch self {
        case .rock:
            return Image("Rock")
        case .paper:
            return Image("Paper")
        case .scissors:
            return Image("Scissors")
        }
    }
    
    
    var decorativeImage: Image {
        switch self {
        case .rock:
            return Image(decorative: "Rock")
        case .paper:
            return Image(decorative: "Paper")
        case .scissors:
            return Image(decorative: "Scissors")
        }
    }
    
    
    var howToWin: String {
        switch self {
        case .rock:
            return "Rocks crush scissors 💥."
        case .paper:
            return "Paper covers rock 🙈."
        case .scissors:
            return "Scissors cut paper ✂️."
        }
    }
    
    
    var howToLose: String {
        switch self {
        case .rock:
            return "Paper covers rock 🙈."
        case .paper:
            return "Scissors cut paper ✂️."
        case .scissors:
            return "Rocks crush scissors 💥."
        }
    }
}


extension GameItem {
    
    func does(winAgainst otherItem: GameItem) -> Bool {
        switch self {
        case .rock:
            return otherItem == .scissors
        case .paper:
            return otherItem == .rock
        case .scissors:
            return otherItem == .paper
        }
    }
    
    
    func does(loseTo otherItem: GameItem) -> Bool {
        self != otherItem && otherItem.does(winAgainst: self)
    }
}
