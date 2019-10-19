//
//  Outcome.swift
//  RockPaperQuizzers
//
//  Created by CypherPoet on 10/17/19.
// ✌️
//

import Foundation


enum Outcome: String, CaseIterable {
    case win
    case lose
}


extension Outcome {
    var displayValue: String { self.rawValue.capitalized }
}
