//
//  Cache+Entry.swift
//  PadFinder
//
//  Created by CypherPoet on 1/30/20.
// ✌️
//

import Foundation


internal extension Cache {
    
    /// A class (because NSCache entries need to be class instances)
    /// to wrap the underlying value (class or not) that we want to cache.
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
}
