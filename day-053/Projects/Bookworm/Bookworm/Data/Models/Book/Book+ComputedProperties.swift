//
//  Book+ComputedProperties.swift
//  Bookworm
//
//  Created by CypherPoet on 11/17/19.
// ✌️
//

import SwiftUI


extension Book {
    
    var emojiForRating: String {
        switch rating {
        case 1:
            return "🗑"
        case 2:
            return "😒"
        case 3:
            return "😐"
        case 4:
            return "✨"
        case 5:
            return "💯"
        default:
            return "🤷‍♂️"
        }
    }
}
