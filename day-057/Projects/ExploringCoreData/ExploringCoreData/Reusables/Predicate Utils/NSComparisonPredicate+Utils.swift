//
//  PredicateComparison.swift
//  ExploringCoreData
//
//  Created by CypherPoet on 11/22/19.
// ✌️
//

import Foundation


extension NSComparisonPredicate {
    
    
    /// If applicable, makes a string consisting of braces and any characters for operator sensitivity.
    ///
    /// - Parameters:
    ///   - diacriticSensitive: [Diacritic sensitivity](https://en.wikipedia.org/wiki/Diacritic)
    ///     refers to any possible glyphs that might be added to
    ///     a chracter, such as accents or dots.
    static func operatorBraces(
        caseSensitive: Bool,
        diacriticSensitive: Bool
    ) -> String? {
        guard caseSensitive || diacriticSensitive else { return nil }
        
        return "[\(caseSensitive ? "c" : "")\(diacriticSensitive ? "d" : "")]"
    }
    
    
    /// The keyword to use within an NSPredicate expression
    public static func keyword(
        for predicateOperator: Operator
    ) -> String {
        switch predicateOperator {
        case .lessThan:
            return "<"
        case .lessThanOrEqualTo:
            return "<="
        case .greaterThan:
            return ">"
        case .greaterThanOrEqualTo:
            return ">="
        case .equalTo:
            return "="
        case .notEqualTo:
            return "!="
        case .matches:
            return "MATCHES"
        case .like:
            return "LIKE"
        case .beginsWith:
            return "BEGINSWITH"
        case .endsWith:
            return "ENDSWITH"
        case .in:
            return "IN"
        case .customSelector:
            return "CUSTOMSELECTOR"
        case .contains:
            return "CONTAINS"
        case .between:
            return "BETWEEN"
        @unknown default:
            return ""
        }
    }
    
    
    public static func stringValue(
        for predicateOperator: Operator,
        caseSensitive: Bool = true,
        diacriticSensitive: Bool = true
    ) -> String {
        let braces = Self.operatorBraces(
            caseSensitive: caseSensitive,
            diacriticSensitive: diacriticSensitive
        )
        
        return "\(Self.keyword(for: predicateOperator))\(braces ?? "")"
    }
}
