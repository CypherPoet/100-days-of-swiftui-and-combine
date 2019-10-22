//
//  Bundle+DecodeFromFileName.swift
//  WordScramble
//
//  Created by CypherPoet on 10/22/19.
// ✌️
//

import Foundation


extension Bundle {

    public func createString(
        fromFileNamed fileName: String,
        withExtension extensionName: String? = nil
    ) throws -> Result<String, Error> {
        guard let url = url(forResource: fileName, withExtension: extensionName) else {
            return .success("")
        }
        
        do {
            return .success(try String(contentsOf: url))
        } catch {
            return .failure(error)
        }
    }
}



