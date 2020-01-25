//
//  DataLoader.swift
//  Moonshot
//
//  Created by CypherPoet on 11/2/19.
// ✌️
//

import Foundation
import Combine
import CypherPoetCore_FileSystem


struct DataLoader {
    static let shared = DataLoader()
    
    enum Error: Swift.Error {
        case fileNotFound
        case failedToLoadData(Swift.Error)
        case generic(Swift.Error)
    }
    
    
    func decodeJSON<T: Decodable>(
        fromFileNamed fileName: String,
        withExtension extensionName: String = "json",
        using decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, DataLoader.Error> {
        Just(Bundle.main)
            .map { $0.url(forResource: fileName, withExtension: extensionName) }
            .tryMap { url throws -> Data in
                guard let url = url else {
                    throw Error.fileNotFound
                }
                
                do {
                    return try Data(contentsOf: url)
                } catch {
                    throw Error.failedToLoadData(error)
                }
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { Error.generic($0) }
            .eraseToAnyPublisher()
    }
}
