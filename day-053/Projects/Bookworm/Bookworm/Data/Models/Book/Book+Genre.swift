//
//  Book+Genre.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//

import Foundation


extension Book {
    
    enum Genre: Int16 {
        case art
        case science
        case scienceFiction
        case fantasy
        case math
        case history
        case economics
        case technology
        case softwareEngineering
        case gameDesign
        case horror
        case mystery
        case misc
    }
}

extension Book.Genre: CaseIterable {}

extension Book.Genre: Identifiable {
    var id: Int16 { rawValue }
}


// MARK: - Computeds
extension Book.Genre {
    
    var displayValue: String {
        switch self {
        case .art:
            return "Art"
        case .science:
            return "Science"
        case .scienceFiction:
            return "Science-Fiction"
        case .fantasy:
            return "Fantasy"
        case .math:
            return "Math"
        case .history:
            return "History"
        case .economics:
            return "Economics"
        case .technology:
            return "Technology"
        case .softwareEngineering:
            return "Software Engineering"
        case .gameDesign:
            return "Game Design"
        case .horror:
            return "Horror"
        case .mystery:
            return "Mystery"
        case .misc:
            return "Miscellaneous"
        }
    }
}
