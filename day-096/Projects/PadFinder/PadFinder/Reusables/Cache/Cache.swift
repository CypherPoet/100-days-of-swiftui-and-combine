//
//  Cache.swift
//  PadFinder
//
//  Created by CypherPoet on 1/30/20.
// ✌️
//

import Foundation


final class Cache<Key: Hashable, Value> {
    private let wrappedCache = NSCache<WrappedKey, Entry>()
}


// MARK: - Public API Methods
extension Cache {
    
    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value)
        
        wrappedCache.setObject(entry, forKey: WrappedKey(key))
    }
    
    
    func value(forKey key: Key) -> Value? {
        if let entry = wrappedCache.object(forKey: WrappedKey(key)) {
            return entry.value
        } else {
            return nil
        }
    }
    
    
    func removeValue(forKey key: Key) {
        wrappedCache.removeObject(forKey: WrappedKey(key))
    }
}


// MARK: - Subscript
extension Cache {
    
    subscript(key: Key) -> Value? {
        get { value(forKey: key) }
        
        set {
            guard let valueToCache = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                removeValue(forKey: key)
                return
            }
            
            insert(valueToCache, forKey: key)
        }
    }
}
