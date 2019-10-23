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
        withExtension extensionName: String? = nil,
        then completionHandler: ((Result<String, Error>) -> Void)
    ) {
        guard let url = url(forResource: fileName, withExtension: extensionName) else {
            let fileDebugName = extensionName == nil ? fileName : "\(fileName).\(extensionName)"
            fatalError("No url found for file named \(fileDebugName)")
        }
        
        do {
            completionHandler(.success(try String(contentsOf: url)))
        } catch {
            completionHandler(.failure(error))
        }
    }
}
