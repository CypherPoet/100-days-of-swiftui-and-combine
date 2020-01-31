//
//  Cache+WrappedKey.swift
//  PadFinder
//
//  Created by CypherPoet on 1/30/20.
// ✌️
//

import Foundation


internal extension Cache {
    
    /// A class that inherits from `NSObject` (because NSCache keys need to
    /// do so) and wraps the underlying key (anything `Hashable`, class or not),
    /// that we want to use with a cache entry.
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }

     
        override var hash: Int { key.hashValue }
        
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let otherValue = object as? WrappedKey else { return false }
            
            return otherValue.key == key
        }
    }
}
