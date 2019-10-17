//
//  View+ConditionallyApply.swift
//  WeSplit
//
//  Created by CypherPoet on 10/16/19.
// ✌️
//


import Foundation
import SwiftUI


extension View {
    
    /// Conditionally applies a modifier to a view, based upon the truthiness of a predicate.
    ///
    /// This allows us to declaratively use conditional modifiers that may result in a different type
    /// based upon the predicate within the same function that has to return `some View`.
    public func conditionallyApply<Modifier>(
        _ modifier1: Modifier,
        if predicate: Bool
    ) -> some View
        where Modifier: ViewModifier
    {
        Group {
            if predicate {
                self.modifier(modifier1)
            } else {
                self
            }
        }
    }
    
    
    /// Conditionally applies a modifier to a view, based upon the truthiness of a predicate.
    ///
    /// This allows us to declaratively use conditional modifiers that may result in a different type
    /// based upon the predicate within the same function that has to return `some View`.
    public func conditionallyApply<Modifier1, Modifier2>(
        _ modifier1: Modifier1,
        if predicate: Bool,
        otherwiseApply modifier2: Modifier2
    ) -> some View where
        Modifier1: ViewModifier,
        Modifier2: ViewModifier
    {
        Group {
            if predicate {
                self.modifier(modifier1)
            } else {
                self.modifier(modifier2)
            }
        }
    }
}
