//
//  GCD.swift
//  DrawingSandbox
//
//  Created by CypherPoet on 11/7/19.
// ✌️
//

import Foundation


public func gcd(_ a: Int, b: Int) -> Int {
    precondition(a != 0)
    
    guard b != 0 else { return a }
        
    return gcd(b, b: a % b)
}
